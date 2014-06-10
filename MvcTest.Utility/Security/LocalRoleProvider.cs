using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mvc.Data;
using System.Web.Security;
using Mvc.Entity.Member;

namespace MvcTest.Utility.Security
{
    public class LocalRoleProvider : RoleProvider
    {
        private UserReposiatory repository;
        public LocalRoleProvider()
        {
            this.repository = new UserReposiatory();
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetRolesForUser(string username)
        {
            Role role = this.repository.GetRoleForUser(username);
            if (!this.repository.RoleExists(role))
            {
                return new string[] { string.Empty };
            }
            return new string[] { role.Name };
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            User user = repository.GetUser(username);
            Role role = repository.GetRole(roleName);
            if (!repository.UserExists(user)) return false;
            if (!repository.RoleExists(role)) return false;
            return user.Role.Name == role.Name;
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}
