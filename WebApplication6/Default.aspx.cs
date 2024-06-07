using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Services;
using System.Web.UI;

namespace WebApplication6
{
    public class Employee//employee class
    {
        public string Name { get; set; }
        public string Department { get; set; }
        public decimal Salary { get; set; }
        public string Manager { get; set; }
    }

    public partial class _Default : Page
    {
        protected static List<Employee> Employees; //lista me antikeimena employees

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string filePath = Server.MapPath("~/App_Data/Employees.csv");//path tou csv

                try
                {
                    Employees = ReadCsvFile(filePath);//call to method
                    BindGridView(Employees);//perasma data sto gridview me functions apo gridview documentation
                    BindDepartments(Employees);
                }
                catch (Exception ex)
                {
                    throw new Exception("Error loading employee data: " + ex.Message, ex);//gia errors
                }
            }
        }

        private List<Employee> ReadCsvFile(string filePath)//gia diavasma tou csv
        {
            var employees = new List<Employee>();
            try
            {
                using (StreamReader sr = new StreamReader(filePath))
                {
                    while (!sr.EndOfStream)
                    {
                        string[] rows = sr.ReadLine().Split(',');//ta dedomeno xwrizonai me ","
                        employees.Add(new Employee//pernaei ta object stin lista
                        {
                            Name = rows[0],
                            Department = rows[1],
                            Salary = decimal.Parse(rows[2]),
                            Manager = rows[3]
                        });
                    }
                }
                return employees;
            }
            catch (Exception ex)
            {
                throw new Exception("Error reading CSV file: " + ex.Message, ex);//errors
            }
        }
        //apo documentation gridview
        private void BindGridView(List<Employee> employees)
        {
            GridView1.DataSource = employees;
            GridView1.DataBind();
        }
        //apo documentation gridview
        private void BindDepartments(List<Employee> employees)
        {
            var departments = employees.Select(e => e.Department).Distinct().ToList();
            departments.Insert(0, "All");
            DropDownListDepartments.DataSource = departments;
            DropDownListDepartments.DataBind();
        }

       
    }
}