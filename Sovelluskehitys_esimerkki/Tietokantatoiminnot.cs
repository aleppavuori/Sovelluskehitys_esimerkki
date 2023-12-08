using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace Sovelluskehitys_esimerkki
{
    internal class Tietokantatoiminnot
    {
        string polku = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=M:\\soveluskehitys\\tuotekanta.mdf;Integrated Security=True;Connect Timeout=30";

        public void paivitaDataGrid(string kysely, string taulu, DataGrid grid)
        {
            SqlConnection kanta = new SqlConnection(polku);
            kanta.Open();

            /*tehdään sql komento*/
            SqlCommand komento = kanta.CreateCommand();
            komento.CommandText = kysely; // kysely

            /*tehdään data adapteri ja taulu johon tiedot haetaan*/
            SqlDataAdapter adapteri = new SqlDataAdapter(komento);
            DataTable dt = new DataTable(taulu);
            adapteri.Fill(dt);

            /*sijoitetaan data-taulun tiedot DataGridiin*/
            grid.ItemsSource = dt.DefaultView;

            kanta.Close();
        }

        public void paivitaComboBox(ComboBox kombo1, ComboBox kombo2)
        {
            SqlConnection kanta = new SqlConnection(polku);
            kanta.Open();

            SqlCommand komento = new SqlCommand("SELECT * FROM tuotetiedot", kanta);
            SqlDataReader lukija = komento.ExecuteReader();

            DataTable dt = new DataTable();
            dt.Columns.Add("ID", typeof(string));
            dt.Columns.Add("TUOTE", typeof(string));

            kombo1.ItemsSource = dt.DefaultView;
            kombo1.DisplayMemberPath = "TUOTE";
            kombo1.SelectedValuePath = "ID";

            kombo2.ItemsSource = dt.DefaultView;
            kombo2.DisplayMemberPath = "TUOTE";
            kombo2.SelectedValuePath = "ID";

            while (lukija.Read())
            {
                int id = lukija.GetInt32(0);
                string tuote = lukija.GetString(1);
                dt.Rows.Add(id, tuote);
            }

            lukija.Close();
            kanta.Close();
        }
    }
}
