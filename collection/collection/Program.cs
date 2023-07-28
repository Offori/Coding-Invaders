using System;

namespace chalange
{
    class Program
    {
        static void Main(string[] args)
        {
            var StudentName = new list<string>();
            var StudentGrade = new list<int>();
            var StudentCount = true;
            while (StudentCount)
            {
                Console.WriteLine("what's your name ?");
                StudentName.Add(Console.ReadLine());
                Console.WriteLine("what's your grade ?");
                StudentGrade.Add(int.Parse(Console.ReadLine()));
                Console.WriteLine("Do you want to enter again a student? (y/n)");
                if (Console.ReadLine() != "y")
                {
                    Console.WriteLine("thanks for registering");
                    StudentCount = false;
                    break;
                }
            }
            for (int i = 0; i < StudentName.Count; i++)
            {
                Console.WriteLine("your details are follow : name : {0} , grade : {1}", StudentName[i], StudentGrade[i]);
            }
        }
    }
}
