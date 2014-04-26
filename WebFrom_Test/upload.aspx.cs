using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Context.Request.Files["scorefile"] != null)
        {
            HttpPostedFile file = this.Context.Request.Files["scorefile"];
            file.SaveAs(Server.MapPath("~/") + file.FileName);
        }

        DataTable dt = ReadExcel();
        Response.Write("hello");
        Response.End();
    }

    private DataTable ReadExcel()
    {
        var fileName = @"C:\Users\cli\Desktop\TestProject\WebFrom_Test\temp.XLS";
        var connectionString = string.Format("Provider=Microsoft.Jet.OLEDB.4.0; data source={0}; Extended Properties=Excel 8.0;", fileName);
        var adapter = new OleDbDataAdapter("SELECT * FROM [sheet1$]", connectionString);
        var ds = new DataSet();
        adapter.Fill(ds, "anyNameHere");
        DataTable data = ds.Tables["anyNameHere"];
        return data;
    }
}
