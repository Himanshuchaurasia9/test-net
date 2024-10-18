using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Xml.Linq;
using System.Drawing;


namespace CrudProject
{
    public partial class Default : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUsers();
            }
        }

        protected void btncreate_Click(object sender, EventArgs e)
        {
            using (SqlConnection _con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("Insert into Users(Name, Email, Gender, DateOfBirth, Password, PhoneNumber) Values(@Name, @Email, @Gender, @DateOfBirth, @Password, @PhoneNumber)",_con);
                cmd.Parameters.AddWithValue("@Name", txtname.Text);
                cmd.Parameters.AddWithValue("@Email", txtemail.Text);
                cmd.Parameters.AddWithValue("@Gender", DropDownGender.SelectedValue);
                cmd.Parameters.AddWithValue("@DateOfBirth",txtdob.Text);
                cmd.Parameters.AddWithValue("@Password", txtpassword.Text);
                cmd.Parameters.AddWithValue("@PhoneNumber", txtphone.Text);
                _con.Open();
                cmd.ExecuteNonQuery();
                Lmessage.Text = "user created successfully";
                clear();
                _con.Close();
                
            }

        }
       
        public void clear()
        {
            txtname.Text = "";
            txtemail.Text = "";
            txtdob.Text = "";
            txtpassword.Text = "";
            txtphone.Text = "";
            DropDownGender.SelectedValue = "Male";
        }
        void GetUsers()
        {
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("Select * from Users", conn);
            SqlDataAdapter sd = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sd.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("Update Users Set Name=@Name, Email=@Email, Gender=@Gender, DateOfBirth=@DateOfBirth, Password=@Password, PhoneNumber=@PhoneNumber Where Id=@ID",conn);
                cmd.Parameters.AddWithValue("@ID", int.Parse(txtid.Text));
                cmd.Parameters.AddWithValue("@Name", txtname.Text);
                cmd.Parameters.AddWithValue("@Email", txtemail.Text);
                cmd.Parameters.AddWithValue("@Gender", DropDownGender.SelectedValue);
                cmd.Parameters.AddWithValue("@DateOfBirth", txtdob.Text);
                cmd.Parameters.AddWithValue("@Password", txtpassword.Text);
                cmd.Parameters.AddWithValue("@PhoneNumber", txtphone.Text);
                conn.Open();
                cmd.ExecuteNonQuery();
                Lmessage.Text = "user created successfully";
                clear();
                conn.Close();

            }

        }
    }

}
