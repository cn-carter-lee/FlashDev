using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using System.Runtime;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.EntityClient;
using System.Linq.Expressions;
using System.Data.Objects;
using System.Data.Entity.Infrastructure;
using System.Threading;
using System.ComponentModel.DataAnnotations.Schema;
using System.Web;
using System.Data.SqlClient;
using MvcTest.Models;


[Table("blog")]
public class Blog
{
    [Key, Required]
    public long Id { set; get; }
    public string Name { set; get; }
}

public class DataContext : DbContext
{
    public DataContext()
        : base("TeacherDB")
    { }

    public DbSet<StudentTag> StudentTags { get; set; }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {

    }
}

public class DataGateway<TContext> where TContext : DbContext, new()
{

    private static DataGateway<TContext> instance = new DataGateway<TContext>();
    private static DbContextManager defaultContextMgr = InitContextManager();

    private DataGateway()
    {
    }

    public static DataGateway<TContext> Instance
    {
        get
        {
            return instance;
        }
    }

    public DbContextManager ContextManager
    {
        get
        {
            return defaultContextMgr;
        }
    }

    /// <summary>
    /// Get entities by raw sql
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <param name="query"></param>
    /// <param name="parameters"></param>
    /// <returns></returns>
    public IEnumerable<TEntity> GetEntitiesByRawSql<TEntity>(string query, params object[] parameters)
    {
        return this.DbContext.Database.SqlQuery<TEntity>(query, parameters);
    }

    /// <summary>
    /// Execute raw sql command
    /// </summary>
    /// <param name="query"></param>
    /// <param name="parameters"></param>
    /// <returns></returns>
    public void ExecuteSqlCommand(string sql, params object[] parameters)
    {
        this.DbContext.Database.ExecuteSqlCommand(sql, parameters);
    }

    /// <summary>
    /// Get All entities
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <returns></returns>
    public DbSet<TEntity> GetEntities<TEntity>() where TEntity : class
    {
        return this.DbContext.Set<TEntity>();
    }

    /// <summary>
    /// Adds the given entity to the context underlying the set in the Added state
    /// such that it will be inserted into the database when DbContext.SaveChanges or Save is called.
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <param name="entity"></param>
    public void Add<TEntity>(TEntity entity) where TEntity : class
    {
        this.GetEntities<TEntity>().Add(entity);
    }

    /// <summary>
    /// Marks the given entity as Modified such that it will be updated to the database when DbContext.SaveChanges or Save is called. 
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <param name="entity"></param>
    public void Update<TEntity>(TEntity entity) where TEntity : class
    {
        this.DbContext.Entry(entity).State = System.Data.EntityState.Modified;
    }

    /// <summary>
    /// Marks the given entity as Deleted such that it will be deleted from the database when DbContext.SaveChanges or Save is called. 
    /// Note that the entity must exist in the context in some other state before this method is called.
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    /// <param name="entity"></param>
    public void Delete<TEntity>(TEntity entity) where TEntity : class
    {
        this.GetEntities<TEntity>().Remove(entity);
    }

    /// <summary>
    /// Saves all changes made in this context to the underlying database.
    /// </summary>
    public void Save()
    {
        try
        {
            this.DbContext.SaveChanges();
        }
        catch (Exception ex)
        {
            // string excuteSql = SQLStatementLogging.ToTraceString(((IObjectContextAdapter)this.DbContext).ObjectContext);
            // Logging.LoggerProvider.Current.Error(ex, excuteSql);
            throw;
        }
    }

    public TEntity Single<TEntity>(Expression<Func<TEntity, bool>> predicate) where TEntity : class
    {
        return this.GetEntities<TEntity>().FirstOrDefault(predicate);
    }

    public IQueryable<TEntity> Find<TEntity>(Expression<Func<TEntity, bool>> predicate) where TEntity : class
    {
        return this.GetEntities<TEntity>().Where(predicate);
    }

    public TEntity FindByKey<TEntity>(params object[] keyValues) where TEntity : class
    {
        return this.GetEntities<TEntity>().Find(keyValues);
    }

    public DateTime GetDbDate()
    {
        return this.ObjectContext.CreateQuery<DateTime>("SqlServer.GETDATE()").ToArray<DateTime>()[0];
    }

    public DataSet ExecuteStoredProcedure(string storedProcedureName, params SqlParameter[] parameters)
    {
        // System.Data.SqlClient.SqlParameter

        var connectionString = ((EntityConnection)this.ObjectContext.Connection).StoreConnection.ConnectionString;
        var ds = new DataSet();

        using (var conn = new SqlConnection(connectionString))
        {
            using (var cmd = conn.CreateCommand())
            {
                cmd.CommandText = storedProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                foreach (var parameter in parameters)
                {
                    cmd.Parameters.Add(parameter);
                }

                using (var adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(ds);
                }
            }
        }

        return ds;
    }

    /// <summary>
    /// DbContext instance
    /// </summary>
    private TContext DbContext
    {
        get
        {
            return (TContext)defaultContextMgr.GetContext();
        }
    }

    private ObjectContext ObjectContext
    {
        get
        {
            return ((IObjectContextAdapter)this.DbContext).ObjectContext;
        }
    }

    private static DbContextManager InitContextManager()
    {
        Type type = null;
        if (HttpContext.Current != null)
        {
            type = typeof(HttpRequestContextManager<>);
        }
        else
        {
            type = typeof(ThreadScopedContextManager<>);
        }

        return (DbContextManager)Activator.CreateInstance(type.MakeGenericType(typeof(TContext)));
    }
}

public abstract class DbContextManager
{
    public const string DBCONTEXT_KEY = "_DBCONTEXT_KEY_";
    public abstract DbContext GetContext();
    public abstract void ReleaseContext();
}


public class HttpRequestContextManager<T> : DbContextManager where T : DbContext, new()
{
    public override DbContext GetContext()
    {
        if (HttpContext.Current == null)
        {
            throw new NotSupportedException("This object can only be used in a HTTP context.");
        }

        if (!HttpContext.Current.Items.Contains(DBCONTEXT_KEY))
        {
            var ctx = new T();
            HttpContext.Current.Items[DBCONTEXT_KEY] = ctx;
            return ctx;
        }

        return HttpContext.Current.Items[DBCONTEXT_KEY] as T;
    }

    public override void ReleaseContext()
    {
        if (HttpContext.Current == null)
        {
            throw new NotSupportedException("This object can only be used in a HTTP context.");
        }

        DbContext ctx;
        if (!HttpContext.Current.Items.Contains(DBCONTEXT_KEY))
        {
            return;
        }

        ctx = HttpContext.Current.Items[DBCONTEXT_KEY] as T;
        if (ctx != null)
        {
            ctx.Dispose();
        }

        HttpContext.Current.Items.Remove(DBCONTEXT_KEY);
    }
}

public class ThreadScopedContextManager<T> : DbContextManager where T : DbContext, new()
{
    [ThreadStatic]
    private static T context;

    public override DbContext GetContext()
    {
        if (context == null)
        {
#if DEBUG
            Console.WriteLine("{0} create DbContext.", Thread.CurrentThread.ManagedThreadId);
#endif
            context = new T();
        }

        return context;
    }

    public override void ReleaseContext()
    {
        if (context != null)
        {
            context.Dispose();
            context = null;
#if DEBUG
            Console.WriteLine("{0} dispose DbContext.", Thread.CurrentThread.ManagedThreadId);
#endif
        }
    }
}
