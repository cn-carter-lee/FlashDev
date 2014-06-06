using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

[Table("Users")]
public class UserObj
{
    [Column]
    [Key]
    public int UserID { get; set; }
    [Column]
    public string UserName { get; set; }
    [Column]
    public string Password { get; set; }
    [Column]
    public string UserEmailAddress { get; set; }
}
