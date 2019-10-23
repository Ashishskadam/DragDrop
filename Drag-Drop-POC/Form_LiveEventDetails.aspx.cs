using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Drawing;

public partial class Form_LiveEventDetails : System.Web.UI.Page
{

    string str = ConfigurationManager.ConnectionStrings["ConStr"].ConnectionString;
    SqlConnection con = new SqlConnection();
    SqlCommand cmd;
    SqlDataReader dr;
    SqlDataAdapter da;
    DataSet ds;

    string UserName = "";
    int Employee_Id = 0, EventHeaderId = 0, CallFor = 0;
    DateTime FromDate, Todate;
    DateTime CurrentUtc_IND = DateTime.UtcNow.AddHours(5).AddMinutes(30);
    public List<CS_EventDetail> List_EventDetail { get { return (List<CS_EventDetail>)Session["CS_EventDetail"]; } set { Session["CS_EventDetail"] = value; } }
    public int RowIndex { get { return (int)ViewState["RowIndex"]; } set { ViewState["RowIndex"] = value; } }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginUsername"] == null || Session["LoginAuthenticated"] == "No")
        {
            Response.Redirect(@"~\Index.aspx");
        }
        else
        {
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // ServiceCentre_Id = Convert.ToInt32(Session["ServiceCentre_Id"].ToString());
            UserName = Session["LoginUsername"].ToString();
            Employee_Id = Convert.ToInt32(Session["LoginEmployee_Id"].ToString());

            if (Request.QueryString.Count > 0)
            {
                try
                {
                    EventHeaderId = Convert.ToInt32(Decrypt(Request.QueryString["ID"].ToString()));
                    CallFor = Convert.ToInt32(Decrypt(Request.QueryString["Call"].ToString()));

                }
                catch
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Invalid Operation');window.location='Home.aspx'", true);
                }
            }

            if (!IsPostBack)
            {
                RowIndex = 0;
                List_EventDetail = new List<CS_EventDetail>();

               
                    Fill_LiveGrid();
                
                Fill_EventLabel();
               


            }
        }
    }
    private void Fill_EventLabel()
    {
        String EventLabel = "";

        if (EventHeaderId != 0)
        {
            con.ConnectionString = str;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandText = "Select EventHeaderId,(EventLabel+' : '+'Pay Grading Fee for Kyu : '+B.Level+'and Start Date : '+Convert(varchar,EventDate,106)) as Label from tbl_EventHeader E inner join Tbl_Belt B on E.EventKyuId=B.BeltId   Where IsDeleted=0  and E.EventHeaderId=" + EventHeaderId;
            // cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                EventLabel = dr["Label"].ToString();
            }
            if (!String.IsNullOrEmpty(EventLabel))
            {
                Lbl_EventLabel.Text = EventLabel.ToString();
            }
            dr.Close();
            con.Close();
        }
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

    private void Fill_LiveGrid()
    {
        List_EventDetail.Clear();
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
            while (dr.Read())
            {
                IndexToAdd = List_EventDetail.Count;
                List_EventDetail.Add(new CS_EventDetail()
                {
                    Index = IndexToAdd,
                    EventHeaderId = Convert.ToInt32(dr["EventHeaderId"].ToString()),
                    StudentId = Convert.ToInt32(dr["StudentId"].ToString()),
                    Label = dr["Label"].ToString(),
                    FullName = dr["FullName"].ToString(),
                    Fees = Convert.ToDouble(dr["Fees"].ToString()),
                    FeesPaid = Convert.ToDouble(dr["FeesPaid"].ToString()),
                    MembershipFee = dr["MembershipFee"].ToString(),
                    DojoName = dr["DojoName"].ToString(),
                    Grade = dr["Grade"].ToString(),
                    EventKyuId = Convert.ToInt32(dr["EventKyuId"].ToString()),
                    GradingFeeStatus = dr["GradingFeeStatus"].ToString(),
                    GradingFeeStatusLable =dr["GradingFeeStatusLable"].ToString()
                });
            }
            dr.Close();
            con.Close();

            for (int i = 0; i < List_EventDetail.Count; i++)
            {
                List_EventDetail[i].Index = i;
                List_EventDetail[i].SrNo = List_EventDetail[i].Index + 1;
            }
            Gv_Event.DataSource = List_EventDetail;
            Gv_Event.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error occured :" + ex.Message.ToString() + "')", true);
        }
    }
    protected void Btn_Move_Click(object sender, EventArgs e)
    {

    }
    protected void Btn_ViewPayment_Click(object sender, EventArgs e)
    {
        int StudentId = 0, EventId = 0;
        var Index = ((GridViewRow)((Control)sender).NamingContainer).RowIndex;

        LinkButton Btn_ViewPayment = (LinkButton)Gv_Event.Rows[Index].FindControl("Btn_ViewPayment");
        StudentId = Convert.ToInt32(Btn_ViewPayment.CommandArgument.ToString());

        Fill_ViewPayment(StudentId);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", " $('#Modal_Payment').modal({backdrop: 'static',keyboard: false})", true);
    }
    protected void Btn_Note_Click(object sender, EventArgs e)
    {
        int StudentId = 0, EventId = 0;
        var Index = ((GridViewRow)((Control)sender).NamingContainer).RowIndex;

        LinkButton Btn_Note = (LinkButton)Gv_Event.Rows[Index].FindControl("Btn_Note");
        StudentId = Convert.ToInt32(Btn_Note.CommandArgument.ToString());
        EventId = Convert.ToInt32(EventHeaderId);
        BindNote(EventId, StudentId);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", " $('#Modal_Note').modal({backdrop: 'static',keyboard: false})", true);
    }
   
    protected void Btn_ViewEventDetail_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"~\Form_EventDetail.aspx?ID=" + encrypt("0") + "&Call=" + encrypt("0"));
    }
    protected void btn_FinishGrade_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"~\Form_LiveEventDetails.aspx?ID=" + encrypt("0") + "&Call=" + encrypt("1"));
    }
    private void BindNote(int EventHeaderId, int StudentId)
    {
        int StudentEventNoteId = 0;
        con.ConnectionString = str;
        cmd = new SqlCommand();
        cmd.CommandText = "Select StudentEventNoteId,StudentId,EventHeaderId,Note from tbl_StudentEventNote Where  IsDeleted=0 and EventHeaderId=" + EventHeaderId + "and StudentId=" + StudentId;
        cmd.Connection = con;
        con.Open();
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            Tb_Note.Text = dr["Note"].ToString();
            StudentEventNoteId = Convert.ToInt32(dr["StudentEventNoteId"].ToString());
            Hf_StudentEnentNoteId.Value = StudentEventNoteId.ToString();
        }
        dr.Close();
        con.Close();

    }
    protected void btn_SaveNote_Click(object sender, EventArgs e)
    {

        int EventId = 0, StudId = 0, NoteId = 0;
        EventId = Convert.ToInt32(EventHeaderId.ToString());
        StudId = Convert.ToInt32(Hf_StudentId.Value);

        NoteId = Convert.ToInt32(Hf_StudentEnentNoteId.Value);


        string Note = "";
        if (!String.IsNullOrEmpty(Tb_Note.Text))
        {
            Note = Tb_Note.Text;

            if (NoteId == 0)
            {

                con.ConnectionString = str;
                cmd = new SqlCommand();
                con.Open();
                SqlTransaction tran = con.BeginTransaction();
                cmd.Transaction = tran;

                try
                {
                    cmd.CommandText = "USP_StudentEventNoteInsert";
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@EventHeaderId", EventHeaderId);
                    cmd.Parameters.AddWithValue("@StudentId", StudId);
                    cmd.Parameters.AddWithValue("@Note", Note);
                    cmd.Parameters.AddWithValue("@CreateDate", CurrentUtc_IND);
                    cmd.Parameters.AddWithValue("@CreatedBy", UserName);
                    cmd.ExecuteNonQuery();
                    tran.Commit();
                    con.Close();
                    cmd.Parameters.Clear();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Note Save successfully.')", true);

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                con.ConnectionString = str;
                cmd = new SqlCommand();
                con.Open();
                SqlTransaction tran = con.BeginTransaction();
                cmd.Transaction = tran;

                try
                {
                    cmd.CommandText = "USP_StudentEventNoteUpdate";
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@StudentEventNoteId", NoteId);
                    cmd.Parameters.AddWithValue("@Note", Note);
                    cmd.Parameters.AddWithValue("@CreateDate", CurrentUtc_IND);
                    cmd.Parameters.AddWithValue("@CreatedBy", UserName);
                    cmd.ExecuteNonQuery();
                    tran.Commit();
                    con.Close();
                    cmd.Parameters.Clear();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Note Updated successfully.')", true);

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please Enter Note')", true);
        }
    }

    private void Fill_ViewPayment(int StudentId)
    {
        double FeePaid = 0, GradingFee = 0;
        string FeeDate = "";
        try
        {
            con.ConnectionString = str;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandText = "USP_Get_PaymentDetailForView";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@StudentId", StudentId);
            cmd.Connection = con;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                FeePaid = Convert.ToDouble(dr["AmountPaid"].ToString());
                FeeDate = dr["MembershipDate"].ToString();
                GradingFee = Convert.ToDouble(dr["GradingFee"].ToString());
            }
            dr.Close();
            con.Close();
            Tb_FeePaid.Text = FeePaid.ToString();
            Tb_GradingFee.Text = GradingFee.ToString();
            Lbl_Date.Text = FeeDate.ToString();
            Lbl_GradingDate.Text = "";

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error occured :" + ex.Message.ToString() + "')", true);
        }

    }
}