using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class capture : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = Request["image"];
        byte[] decodeData = new byte[str.Length];
        decodeData = Convert.FromBase64String(str);
        string filename = "c" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpg";
        string filepath = Server.MapPath(@"" + filename);
        System.IO.File.WriteAllBytes(filepath, decodeData);
        Response.Write(filename);
        Response.End();
    }
}