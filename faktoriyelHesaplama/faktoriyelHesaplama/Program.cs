using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace faktoriyelHesaplama
{
    internal class Program
    {
        static int faktoriyel(int sayi)
        {
            int sonuc = 1;
            for (int i = 1; i <= sayi; i++)
            {
                sonuc *= i;
            }
            Console.WriteLine("Sonuç: " + sonuc);
            return sonuc;
        }

        static void Main()
        {
            do
            {
                Console.Write("Faktoriyeli hesaplanacak sayıyı giriniz: ");
                int sayi = Convert.ToInt32(Console.ReadLine());
                faktoriyel(sayi);

                Console.Write("Başka sayı hesaplamak istiyor musunuz? (Evet/Hayır): ");
                string cevap = Console.ReadLine().ToUpper();

                if (cevap != "EVET")
                {
                    break;
                }

            }
            while (true);
            Console.WriteLine("Program sonlandı.");
            Console.ReadKey();
        }
    }
}
