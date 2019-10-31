using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Drag_Drop_POC
{
    public partial class Home : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["ConStr"].ConnectionString;
        SqlConnection con = new SqlConnection();
        SqlCommand cmd;
        SqlDataReader dr;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Fill_LiveGrid();
                //Fill_EventLabel();
            }
        }

        private void Fill_EventLabel()
        {
            String EventLabel = "";


            con.ConnectionString = str;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandText = "Select EventHeaderId,(EventLabel+' : '+'Pay Grading Fee for Kyu : '+B.Level+'and Start Date : '+Convert(varchar,EventDate,106)) as Label from tbl_EventHeader E inner join Tbl_Belt B on E.EventKyuId=B.BeltId   Where IsDeleted=0  and E.EventHeaderId=" + 1;
            // cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                EventLabel = dr["Label"].ToString();
            }
            if (!String.IsNullOrEmpty(EventLabel))
            {
            }
            dr.Close();
            con.Close();
        }

        public string encrypt(string encryptString)
        {
            string EncryptionKey = "SOFTUKKARATE11245PRITMEGHPAGEISSOFT";
            byte[] clearBytes = Encoding.Unicode.GetBytes(encryptString);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {
            0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76
        });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    encryptString = Convert.ToBase64String(ms.ToArray());
                }
            }
            return encryptString;
        }
        public string Decrypt(string cipherText)
        {
            string EncryptionKey = "SOFTUKKARATE11245PRITMEGHPAGEISSOFT";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {
            0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76
        });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }

        private string Fill_LiveGrid()
        {
            //List_EventDetail.Clear();
            int IndexToAdd = 0;
            try
            {
                con.ConnectionString = str;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandText = "USP_Get_LiveEventDetail";
                cmd.CommandType = CommandType.StoredProcedure;
                //  cmd.Parameters.AddWithValue("@EventHeaderId", EventHeaderId);
                cmd.Connection = con;
                dr = cmd.ExecuteReader();
                var list = new List<CS_EventDetail>();
                while (dr.Read())
                {
                    var FullName = dr["FullName"].ToString();
                    //IndexToAdd = CS_EventDetail.Count;
                    list.Add(new CS_EventDetail()
                    {
                        Index = IndexToAdd,
                        EventHeaderId = Convert.ToInt32(dr["EventHeaderId"].ToString()),
                        StudentId = Convert.ToInt32(dr["StudentId"].ToString()),
                        // Label = List_EventDetail,
                        FullName = dr["FullName"].ToString(),
                        Fees = Convert.ToDouble(dr["Fees"].ToString()),
                        FeesPaid = Convert.ToDouble(dr["FeesPaid"].ToString()),
                        MembershipFee = dr["MembershipFee"].ToString(),
                        DojoName = dr["DojoName"].ToString(),
                        Grade = dr["Grade"].ToString(),
                        EventKyuId = Convert.ToInt32(dr["EventKyuId"].ToString()),
                        GradingFeeStatus = dr["GradingFeeStatus"].ToString(),
                        // GradingFeeStatusLable = dr["GradingFeeStatusLable"].ToString()
                    });
                }
                dr.Close();
                con.Close();
               
                var obj = new
                {
                    draw = 1,
                    recordsTotal = 57,
                    recordsFiltered = 57,
                    data = list
                };
                return Newtonsoft.Json.JsonConvert.SerializeObject(list);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error occured :" + ex.Message.ToString() + "')", true);
            }
            return "";
        }
        [WebMethod]
        public static string GetData()
        {
            Home h = new Home();
            return h.Fill_LiveGrid();
        }
    }
}