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
    public partial class FormCount : Form
    {
        int i = 10;
        public FormCount()
        {
            InitializeComponent();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            i--;
            label1.Text = "Tài khoản của bạn tạm khóa trong : " + i.ToString() + " giây";

            if(i==0)
            {
                this.Close();
            }    
        }

        
    }
}
