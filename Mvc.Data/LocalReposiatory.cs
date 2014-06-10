using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mvc.Entity.Member;
using System.Web.Security;

namespace Mvc.Data
{
    public class UserReposiatory
    {
        #region Variables

        private LocalContext entities = new LocalContext();
        private const string MissingRole = "Role does not exist";
        private const string MissingUser = "User does not exist";
        private const string TooManyUser = "User already exist";
        private const string TooManyRole = "Role already exist";
        private const string AssignedRole = "Cannot delete a role with assigned users";

        #endregion

        #region Properties

        public int NumberOfUsers
        {
            get
            {
                return this.entities.Users.Count();
            }
        }

        public int NumberOfRoles
        {
            get
            {
                return this.entities.Roles.Count();
            }
        }

        #endregion

        #region Constructors

        public UserReposiatory()
        {
            this.entities = new LocalContext();
        }

        #endregion

        #region Query Methods

        public IQueryable<User> GetAllUsers()
        {
            return from user in entities.Users
                   orderby user.UserName
                   select user;
        }

        public User GetUser(int userId)
        {
            return entities.Users.SingleOrDefault(user => user.UserID == userId);
        }

        public User GetUser(string userName)
        {
            return entities.Users.SingleOrDefault(user => user.UserName == userName);
        }

        public IQueryable<User> GetUsersForRole(string roleName)
        {
            return GetUsersForRole(GetRole(roleName));
        }

        public IQueryable<User> GetUsersForRole(int roleId)
        {
            return GetUsersForRole(GetRole(roleId));
        }

        public IQueryable<User> GetUsersForRole(Role role)
        {
            if (!RoleExists(role))
                throw new ArgumentException(MissingRole);
            return from user in entities.Users
                   where user.RoleId == role.RoleId
                   orderby user.UserName
                   select user;
        }

        public IQueryable<Role> GetAllRoles()
        {
            return from role in entities.Roles
                   orderby role.Name
                   select role;
        }

        public Role GetRole(int roleId)
        {
            return entities.Roles.SingleOrDefault(role => role.RoleId == roleId);
        }

        public Role GetRole(string name)
        {
            return entities.Roles.SingleOrDefault(role => role.Name == name);
        }

        public Role GetRoleForUser(string userName)
        {
            return GetRoleForUser(GetUser(userName));
        }

        public Role GetRoleForUser(int userId)
        {
            return GetRoleForUser(GetUser(userId));
        }

        public Role GetRoleForUser(User user)
        {
            if (!UserExists(user))
                throw new ArgumentException(MissingUser);
            return user.Role;
        }

        #endregion

        #region Insert/Delete

        private User AddUser(User user)
        {
            if (UserExists(user))
                throw new ArgumentException(TooManyUser);
            return entities.Users.Add(user);
        }

        public void CreateUser(string username, string name, string password, string email, string roleName)
        {
            Role role = GetRole(roleName);
            if (string.IsNullOrEmpty(username.Trim()))
                throw new ArgumentException("The user name provided is invalid. Please check the value and try again.");
            if (string.IsNullOrEmpty(name.Trim()))
                throw new ArgumentException("The name provided is invalid. Please check the value and try again.");
            if (string.IsNullOrEmpty(password.Trim()))
                throw new ArgumentException("The password provided is invalid. Please enter a valid password value.");
            if (string.IsNullOrEmpty(email.Trim()))
                throw new ArgumentException("The e-mail address provided is invalid. Please check the value and try again.");
            if (!RoleExists(role))
                throw new ArgumentException("The role selected for this user does not exist! Contact an administrator!");
            if (this.entities.Users.Any(user => user.UserName == username))
                throw new ArgumentException("Username already exists. Please enter a different user name.");

            User newUser = new User()
            {
                UserName = username,
                Name = name,
                Password = FormsAuthentication.HashPasswordForStoringInConfigFile(password.Trim(), "md5"),
                Email = email,
                RoleId = role.RoleId
            };

            try
            {
                AddUser(newUser);
            }

            catch (ArgumentException e)
            {
                throw e;
            }
            catch (Exception e)
            {
                throw new ArgumentException("The authentication provider returned an error. Please verify your entry and try again. If the problem persists,please contact your system administrator.");
            }

            // Immediately persist the user data
            Save();
        }

        public User DeleteUser(User user)
        {
            if (!UserExists(user)) throw new ArgumentException(MissingUser);
            return entities.Users.Remove(user);
        }

        public Role AddRole(Role role)
        {
            if (RoleExists(role))
                throw new ArgumentException(TooManyRole);
            return entities.Roles.Add(role);

        }

        public Role AddRole(string roleName)
        {
            Role role = new Role()
            {
                Name = roleName
            };
            return AddRole(role);
        }

        public Role DeleteRole(Role role)
        {
            if (!RoleExists(role))
                throw new ArgumentException(MissingRole);
            if (GetUsersForRole(role).Count() > 0)
                throw new ArgumentException(AssignedRole);
            return entities.Roles.Remove(role);
        }

        public Role DeleteRole(string roleName)
        {
            return DeleteRole(GetRole(roleName));
        }

        #endregion

        #region Persistence

        public int  Save()
        {
            return entities.SaveChanges();
        }
        #endregion

        #region Helper Methods

        public bool UserExists(User user)
        {
            if (user == null) return false;
            return (entities.Users.SingleOrDefault(u => u.UserID == user.UserID || u.UserName == user.UserName) != null);
        }

        public bool RoleExists(Role role)
        {
            if (role == null) return false;
            return (entities.Roles.SingleOrDefault(r => r.RoleId == role.RoleId || r.Name == role.Name) != null);
        }

        #endregion
    }
}
