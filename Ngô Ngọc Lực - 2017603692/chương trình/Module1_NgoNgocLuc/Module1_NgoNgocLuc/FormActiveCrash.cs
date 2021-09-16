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
    public partial class FormActiveCrash : Form
    {
        Crash temp;
        
        public FormActiveCrash()
        {
            InitializeComponent();
        }

        private void FormActiveCrash_Load(object sender, EventArgs e)
        {
            Crash crash = (Crash)this.Tag;
            temp = crash;
            label1.Text = "No logout detected for your last login on " + crash.LoginTime.Day + "/" + crash.LoginTime.Month + "/" + crash.LoginTime.Year +" at " + crash.LoginTime.Hour+":" + crash.LoginTime.Minute;
            txtReason.Text = crash.Mota;
            if(crash.TypeError == 1)
            {
                radioButton1.Checked = true;   
            }
            else
            {
                radioButton2.Checked = true;
            }
        }

        private void btnConfirm_Click(object sender, EventArgs e)
        {
            this.Close();
        }

       
    }
    
}
