using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Cryptography;
namespace Module1_NgoNgocLuc
{
    public partial class Login : Form
    {
        int count_false = 0;
        Crash temp = new Crash();
        User ndHientai;
        AmonicDataContext db = new AmonicDataContext();
        StringBuilder passMD5 = new StringBuilder();
        MD5 md = MD5.Create();
        public Login()
        {
            InitializeComponent();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private bool checkCrash()
        {
            var crashs = from cr in db.Crashes
                         where cr.UserID == ndHientai.ID
                         select cr;

            if(crashs.Count()>0)
            {
                foreach (var item in crashs)
                {
                    temp = item;
                };

                return (bool)temp.Crasher;
            }
            else return false;
        }

        private void md5_create(string pass)
        {
            byte[] inputStr = System.Text.Encoding.ASCII.GetBytes(pass);
            byte[] hash = md.ComputeHash(inputStr);

            passMD5.Clear();
            for(int i =0;i< hash.Length; i++)
            {
                passMD5.Append(hash[i].ToString("X2"));
            }    
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if(txtUsername.Text =="" || txtPassword.Text =="")
                {
                    MessageBox.Show("Bạn chưa điền đầy đủ thông tin!");
                }   
                else
                {
                    md5_create(txtPassword.Text);

                     ndHientai  = db.Users.SingleOrDefault(nd => nd.Email == txtUsername.Text && nd.Password.Equals(passMD5));

                    
                    if (ndHientai != null)
                    {

                        if (ndHientai.Active == false)
                        {
                            MessageBox.Show("Tài khoản của bạn đã bị vô hiệu!");
                        }
                        else
                        {

                            if (checkCrash())
                            {
                                FormActiveCrash fActive = new FormActiveCrash();
                                fActive.Tag = temp;
                                fActive.ShowDialog();
                            }

                            if (ndHientai.RoleID == 1)
                            {
                                int y = ndHientai.RoleID;
                                MenuAdmin formAdmin = new MenuAdmin();
                                formAdmin.Tag = ndHientai;
                                formAdmin.Show();
                                this.Hide();
                            }
                            
                            if (ndHientai.RoleID == 2)
                            {
                                FormMenuUser formUser = new FormMenuUser();
                                formUser.Tag = ndHientai;
                                formUser.Show();
                                this.Hide();
                            }
                        }

                    }
                    else
                    {
                        if (count_false >= 2)
                        {
                            FormCount formDem = new FormCount();
                            formDem.ShowDialog();
                            
                        }
                        else
                        {
                            MessageBox.Show("Sai tên tài khoản hoặc mật khẩu!");
                        }
                        count_false++;
                    }
                }    
            }
            catch (Exception ex)
            {

                MessageBox.Show("Lỗi đăng nhập!" + ex.Message);
            }
            
        }

        
    }
}
