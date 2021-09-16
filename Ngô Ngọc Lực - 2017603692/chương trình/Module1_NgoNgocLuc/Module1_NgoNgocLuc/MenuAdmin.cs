using System;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace Module1_NgoNgocLuc
{
    public partial class MenuAdmin : Form
    {
        DateTime timeLogin;

        AmonicDataContext db = new AmonicDataContext();
        DataGridViewRow dongclick;
        //string checkEmail;
        User ndClick;
        User userHT;
        public MenuAdmin()
        {

            InitializeComponent();
        }
        private void MenuAdmin_Load(object sender, EventArgs e)
        {
            User userHT2 = (User)this.Tag;
            userHT = userHT2;
            timeLogin = DateTime.Now;
            taoCrash();
            load_cbo_Office();
            hienThiDL();
        }
        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DialogResult a = MessageBox.Show("Bạn có chắc muốn thoát ứng dụng?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (a == DialogResult.Yes)
            {
                capNhatCrash();
                Application.Exit();
            }
        }
        private void taoCrash()
        {
            Crash crash = new Crash();
            crash.UserID = userHT.ID;
            crash.LoginTime = timeLogin;
            crash.LogoutTime = timeLogin;
            crash.Crasher = true;
            crash.Mota = "Treo";
            crash.TypeError = 2;
            db.Crashes.InsertOnSubmit(crash);
            db.SubmitChanges();
        }
        private void capNhatCrash()
        {

            Crash crash = db.Crashes.SingleOrDefault(c => c.UserID == userHT.ID && c.LoginTime == timeLogin);

            crash.LogoutTime = DateTime.Now;
            crash.Crasher = false;
            crash.Mota = null;
            crash.TypeError = null;
            db.SubmitChanges();
        }

        private void capNhatCrashEx(Exception e)
        {

            Crash crash = db.Crashes.SingleOrDefault(c => c.UserID == userHT.ID && c.LoginTime == timeLogin);

            crash.LogoutTime = DateTime.Now;
            crash.Crasher = true;
            crash.Mota = e.Message;
            crash.TypeError = 1;
            db.SubmitChanges();
        }
        private void load_cbo_Office()
        {
            var offices = from office in db.Offices
                          select office;

            cboAllOffices.DataSource = offices;
            cboAllOffices.DisplayMember = "Title";
            cboAllOffices.ValueMember = "ID";
        }


        private void hienThiDL()
        {
            label2.Text = "Hi " + userHT.FirstName + " .Welcome to Amonic airlines.";
            if (dongclick != null)
            {
                btnChangeRole.Enabled = true;
                btnEnable.Enabled = true;
            }
            else
            {
                btnEnable.Enabled = false;
                btnChangeRole.Enabled = false;
            }

            var users = from nd in db.Users
                        select new
                        {
                            nd.FirstName,
                            nd.LastName,
                            nd.Birthdate,
                            nd.Role.ID,
                            nd.Email,
                            nd.Office.Title,
                            nd.Active
                        };

            dataGridView1.Rows.Clear();

            foreach (var item in users)
            {
                DataGridViewRow dongmoi = (DataGridViewRow)dataGridView1.Rows[0].Clone();

                dongmoi.DefaultCellStyle.BackColor = Color.White;
                dongmoi.Cells[0].Value = item.FirstName;
                dongmoi.Cells[1].Value = item.LastName;
                dongmoi.Cells[2].Value = DateTime.Now.Year - item.Birthdate.Value.Year;
                if (item.ID == 1)
                {
                    dongmoi.DefaultCellStyle.BackColor = Color.LightGreen;
                    dongmoi.Cells[3].Value = "Administrator";
                }
                else
                {
                    dongmoi.Cells[3].Value = "User";
                }

                dongmoi.Cells[4].Value = item.Email;
                dongmoi.Cells[5].Value = item.Title;

                dongmoi.Cells[6].Value = item.Active;
                if ((bool)!item.Active)
                {
                    dongmoi.DefaultCellStyle.BackColor = Color.OrangeRed;

                }
                dataGridView1.Rows.Add(dongmoi);
            }
        }



        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            bool checkActive = (bool)dataGridView1.Rows[e.RowIndex].Cells[6].Value;
            dongclick = dataGridView1.Rows[e.RowIndex];
            string checkEmail = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
            ndClick = db.Users.SingleOrDefault(u => u.Email == checkEmail);
            if (checkActive)
            {
                btnEnable.Text = "Disable login";
            }
            else
            {
                btnEnable.Text = "Enable login";
            }

            if (dongclick != null && dongclick.Cells[4].Value.ToString() != userHT.Email)
            {
                btnChangeRole.Enabled = true;
                btnEnable.Enabled = true;
            }
            else
            {
                btnEnable.Enabled = false;
                btnChangeRole.Enabled = false;
            }


        }

        private void addUserToolStripMenuItem_Click(object sender, EventArgs e)
        {
            dongclick = null;
            ndClick = null;
            FormAddUser fAddUser = new FormAddUser();
            fAddUser.ShowDialog();

        }

        private void btnEnable_Click(object sender, EventArgs e)
        {

            User activeUser = db.Users.SingleOrDefault(u => u.Email == ndClick.Email);

            if (btnEnable.Text == "Disable login")
            {
                DialogResult a = MessageBox.Show("Bạn có chắc muốn đình chỉ người dùng này?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (a == DialogResult.Yes)
                {
                    activeUser.Active = false;
                }

            }
            else
            {
                DialogResult a = MessageBox.Show("Bạn có chắc muốn ngừng đình chỉ người dùng này?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (a == DialogResult.Yes)
                {
                    activeUser.Active = true;
                }

            }
            db.SubmitChanges();

            dongclick = null;
            //checkEmail ="";
            hienThiDL();
        }

        private void btnChangeRole_Click(object sender, EventArgs e)
        {
            FormEditRole fEdit = new FormEditRole();
            fEdit.Tag = ndClick;
            fEdit.ShowDialog();
            ndClick = null;
        }

        private void MenuAdmin_Activated(object sender, EventArgs e)
        {
            load_cbo_Office();
            hienThiDL();
        }



        private void cboAllOffices_SelectionChangeCommitted(object sender, EventArgs e)
        {
            dongclick = null;
            int officeFilterID = int.Parse(cboAllOffices.SelectedValue.ToString());

            var users = from nd in db.Users
                        where nd.OfficeID == officeFilterID
                        select new
                        {
                            nd.FirstName,
                            nd.LastName,
                            nd.Birthdate,
                            nd.Role.ID,
                            nd.Email,
                            nd.Office.Title,
                            nd.Active
                        };

            dataGridView1.Rows.Clear();

            if (users.Count() > 0)
            {
                foreach (var item in users)
                {
                    DataGridViewRow dongmoi = (DataGridViewRow)dataGridView1.Rows[0].Clone();

                    dongmoi.DefaultCellStyle.BackColor = Color.White;
                    dongmoi.Cells[0].Value = item.FirstName;
                    dongmoi.Cells[1].Value = item.LastName;
                    dongmoi.Cells[2].Value = DateTime.Now.Year - item.Birthdate.Value.Year;
                    if (item.ID == 1)
                    {
                        dongmoi.DefaultCellStyle.BackColor = Color.LightGreen;
                        dongmoi.Cells[3].Value = "Administrator";
                    }
                    else
                    {
                        dongmoi.Cells[3].Value = "User";
                    }

                    dongmoi.Cells[4].Value = item.Email;
                    dongmoi.Cells[5].Value = item.Title;

                    dongmoi.Cells[6].Value = item.Active;
                    if ((bool)!item.Active)
                    {
                        dongmoi.DefaultCellStyle.BackColor = Color.OrangeRed;

                    }


                    dataGridView1.Rows.Add(dongmoi);
                }
            }
            else
            {
                MessageBox.Show("Không có dữ liệu để hiển thị!");
            }


        }

        //private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        //{
        //    bool checkActive = (bool)dataGridView1.Rows[e.RowIndex].Cells[6].Value;
        //    dongclick = dataGridView1.Rows[e.RowIndex];
        //    checkEmail = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
        //    ndClick = db.Users.SingleOrDefault(u => u.Email == checkEmail);
        //    if (checkActive)
        //    {
        //        btnEnable.Text = "Disable login";
        //    }
        //    else
        //    {
        //        btnEnable.Text = "Enable login";
        //    }

        //    if (dongclick != null && dongclick.Cells[4].Value.ToString() != userHT.Email)
        //    {
        //        btnChangeRole.Enabled = true;
        //        btnEnable.Enabled = true;
        //    }
        //    else
        //    {
        //        btnEnable.Enabled = false;
        //        btnChangeRole.Enabled = false;
        //    }

        //}
    }
}
