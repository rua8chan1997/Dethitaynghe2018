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
    public partial class FormAddUser : Form
    {
        AmonicDataContext db = new AmonicDataContext();
        MD5 md = MD5.Create();
        StringBuilder passMD5 = new StringBuilder();

        public FormAddUser()
        {
            InitializeComponent();
        }
        private void load_cbo_Office()
        {
            var offices = from office in db.Offices
                          select office;

            cboOffices.DataSource = offices;
            cboOffices.DisplayMember = "Title";
            cboOffices.ValueMember = "ID";
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtEmail.Text == "" || txtFirstName.Text == "" || txtLastName.Text == "" || txtPassword.Text == "" || textBoxConfirmPass.Text=="")
                {
                    MessageBox.Show("Bạn phải điền đầy đủ thông tin!");
                }
                else
                {
                    
                    if(checkUser())
                    {
                        if (txtPassword.Text == textBoxConfirmPass.Text)
                        {
                            if (checkDate())
                            {
                                DialogResult a = MessageBox.Show("Bạn có chắc muốn add User này?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                                if (a == DialogResult.Yes)
                                {
                                    themUser();
                                }
                            }
                            else
                            {
                                MessageBox.Show("Ngày sinh nhập không hợp lệ! Vui lòng kiểm tra lại! ");
                            }

                        }
                        else
                        {
                            MessageBox.Show("Mật khẩu không khớp! Vui lòng kiểm tra lại! ");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Tài khoản này đã tồn tại! Vui lòng kiểm tra lại! ");
                    }
                    
                }
            }
            catch (Exception)
            {

                MessageBox.Show("Lỗi không thể thêm user! Vui lòng thử lại.");
            }
            
        }

        private bool checkUser()
        {
            User user = db.Users.SingleOrDefault(s => s.Email == txtEmail.Text);
            if(user == null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private bool checkDate()
        {
            int time_spent = dateTimePicker1.Value.Year;
            int time_spent2 = DateTime.Now.Year;
            int time1 = time_spent2 - time_spent;
            if(time1<=0)
            {
                return false;
            }
            else
            {
                return true;
            }

        }

        private void FormAddUser_Load(object sender, EventArgs e)
        {
            load_cbo_Office();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult a = MessageBox.Show("Bạn có chắc muốn thoát Add User?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (a == DialogResult.Yes)
            {
                this.Close();
            }
        }

        private void md5_create(string pass)
        {
            byte[] inputStr = System.Text.Encoding.ASCII.GetBytes(pass);
            byte[] hash = md.ComputeHash(inputStr);

            for (int i = 0; i < hash.Length; i++)
            {
                passMD5.Append(hash[i].ToString("X2"));
            }
        }
        private void themUser()
        {
            User addUser = new User();
            md5_create(txtPassword.Text);
            addUser.RoleID = 2;
            addUser.Email = txtEmail.Text;
            addUser.FirstName = txtFirstName.Text;
            addUser.LastName = txtLastName.Text;
            addUser.OfficeID = int.Parse(cboOffices.SelectedValue.ToString());
            addUser.Password = passMD5.ToString();
            addUser.Active = true;

            int day = dateTimePicker1.Value.Day;
            int month = dateTimePicker1.Value.Month;
            int year = dateTimePicker1.Value.Year;

            DateTime date = new DateTime(year, month, day);
            addUser.Birthdate = date;

            db.Users.InsertOnSubmit(addUser);

            db.SubmitChanges();
            DialogResult b = MessageBox.Show("Thêm thành công! bạn có muốn tiếp tục add user?", "thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (b == DialogResult.No)
            {
                this.Close();
            }
            else
            {
                txtEmail.Text = "";
                txtFirstName.Text = "";
                txtLastName.Text = "";
                txtPassword.Text = "";
                textBoxConfirmPass.Text = "";
                cboOffices.Text = "";
                dateTimePicker1.Value = DateTime.Now;
            }
        }
    }
}
