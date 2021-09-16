using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Module1_NgoNgocLuc
{
    public partial class FormMenuUser : Form
    {
        DateTime timeLogin;
        AmonicDataContext db = new AmonicDataContext();
        User userHT;

        public FormMenuUser()
        {
            InitializeComponent();
        }
        private void FormMenuUser_Load(object sender, EventArgs e)
        {
            
            User userHT2 = (User)this.Tag;
            userHT = userHT2;
            timeLogin = DateTime.Now;
            try
            {
                hienThiDL_user();
            }
            catch (Exception ex)
            {

                capNhatCrashEx(ex);
            }
            
            taoCrash();
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
            string str = "System";
            //crash.LogoutTime = DateTime.Now;
            crash.Crasher = true;
            crash.Mota = e.Message;
            if (crash.Mota.Contains(str))
            {
                crash.TypeError = 2;
            }
            else
            {
                crash.TypeError = 1;
            }
            
            db.SubmitChanges();
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

        

        private void hienThiDL_user() {
            
                int count = 0;
                DateTime setdate = Convert.ToDateTime("1/1/2012 12:00:00 AM");

                TimeSpan totalTime = setdate - setdate;
                TimeSpan checkTime = totalTime;
                labelWelcome.Text = "Hi " + userHT.FirstName + ", Welcome to AMONIC Airlines.";
                var crashs = from cr in db.Crashes
                             where cr.UserID == userHT.ID
                             select cr;

                foreach (var item in crashs)
                {
                    //if ((bool)item.Crasher && item.Mota == null)
                    //{

                    //}
                    //else
                    //{
                        DateTime t1 = DateTime.Now;
                        DateTime t2 = item.LoginTime;
                        checkTime = t1 - t2;
                        if (checkTime.Days <= 30)
                        {
                            DataGridViewRow dongmoi = (DataGridViewRow)dataGridView1.Rows[0].Clone();
                            dongmoi.DefaultCellStyle.BackColor = Color.White;
                            dongmoi.Cells[0].Value = item.LoginTime.Month + "/" + item.LoginTime.Day + "/" + item.LoginTime.Year;
                            dongmoi.Cells[1].Value = item.LoginTime.Hour + ":" + item.LoginTime.Minute;

                            if (item.Mota != null)
                            {
                                count++;
                                dongmoi.DefaultCellStyle.BackColor = Color.OrangeRed;
                                dongmoi.Cells[2].Value = "**";

                                dongmoi.Cells[3].Value = "**";
                                dongmoi.Cells[4].Value = item.Mota;
                            }
                            else
                            {
                                DateTime time_spent = item.LoginTime;
                                DateTime time_spent2 = item.LogoutTime;
                                TimeSpan timeRows = time_spent2 - time_spent;
                                totalTime += timeRows;
                                dongmoi.Cells[2].Value = item.LogoutTime.Hour + ":" + item.LogoutTime.Minute;

                                dongmoi.Cells[3].Value = timeRows.Hours + "giờ :" + timeRows.Minutes + "phút :" + timeRows.Seconds + "giây";
                                dongmoi.Cells[4].Value = "";
                            }
                            dataGridView1.Rows.Add(dongmoi);
                        }

                    //}


                }
                label2.Text = "Time spent on system : " + totalTime.Days + "ngày :" + totalTime.Hours + "giờ :" + totalTime.Minutes + "phút :" + totalTime.Seconds + "giây"; ;
                label3.Text = "Number of crashes: " + count;
            
            
        }

        private void FormMenuUser_FormClosing(object sender, FormClosingEventArgs e)
        {
            
                capNhatCrash();
                Application.Exit();
            
        }
    }
}
