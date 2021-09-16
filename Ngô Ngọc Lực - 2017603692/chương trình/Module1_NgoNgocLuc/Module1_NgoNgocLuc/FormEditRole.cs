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
    public partial class FormEditRole : Form
    {
        public FormEditRole()
        {
            InitializeComponent();
        }

        private void FormEditRole_Load(object sender, EventArgs e)
        {
            hienThiDLEdit();
        }
        
        private void hienThiDLEdit()
        {
            User userHT = (User)this.Tag;
            txtEmail.Text = userHT.Email;
            txtFirstName.Text = userHT.FirstName;
            txtLastName.Text = userHT.LastName;
            txtOffice.Text = userHT.Office.Title;
            if(userHT.RoleID == 1)
            {
                radioAdmin.Checked = true;
            }    
            else
            {
                radioUser.Checked = true; 
            }    
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            
            DialogResult a = MessageBox.Show("Bạn có chắc muốn thay đổi quyền của người dùng này?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (a == DialogResult.Yes)
            {
                AmonicDataContext db = new AmonicDataContext();
                User u = db.Users.SingleOrDefault(s => s.Email == txtEmail.Text);
                if(radioAdmin.Checked)
                {
                    u.RoleID = 1;
                }
                else
                {
                    u.RoleID = 2;
                }
                db.SubmitChanges();

                MessageBox.Show("Thay đổi quyền user thành công!");
                this.Close();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult a = MessageBox.Show("Bạn có chắc muốn thoát Edit role?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (a == DialogResult.Yes)
            {
                this.Close();
            }
        }
    }
}
