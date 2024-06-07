<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication6._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title class="titlestyle">Employee Data</title>
    <link rel="stylesheet" type="text/css" href="~/Stylesheet2.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // filtro gia departments
            $("#<%= DropDownListDepartments.ClientID %>").change(function () {
                var selectedDepartment = $(this).val();//pernei to selected value
                filterEmployees(selectedDepartment);//call to function
            });

            // filtro gia text gia ola ta pedia, paromoia
            $("#txtSearch").on("input", function () {
                var searchTerm = $(this).val().toLowerCase();
                filterEmployeesByText(searchTerm);
            });

            function filterEmployees(department) {
                var rows = $("#<%= GridView1.ClientID %> tr");//pairnei ta row
                rows.each(function (index) {
                    if (index === 0) {
                        return; // Skip header row giati exei ta names apo ta columns
                    }
                    var departmentText = $(this).children('td:nth-child(2)').text();
                    if (department === 'All' || departmentText === department) { //deixnei-krivei apotelesmata analoga me to filtro
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }

            function filterEmployeesByText(searchTerm) {//paromoia me to prwto filtro 
                var rows = $("#<%= GridView1.ClientID %> tr");
                rows.each(function (index) {
                    if (index === 0) {
                        return; // Skip header row
                    }
                    var rowText = $(this).text().toLowerCase();
                    if (rowText.includes(searchTerm)) {//emfanizei apotelesmata elegxontas olo to row
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Practical Test Employee Data</h1>
            <div style="text-align: center;">
                <asp:Label ID="Label1" Text="Search by Department" style="margin-right:5px" runat="server"/>
                <div style="display: inline-block; margin-right: 10px; width: 200px;">
                    <asp:DropDownList ID="DropDownListDepartments" runat="server" CssClass="dropdown-list" style="font-size: 16px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; text-align: center; box-sizing: border-box; width: 100%;">
                    </asp:DropDownList>
                </div>or
                <div style="display: inline-block; width: 200px;">
                    <input type="text" id="txtSearch" placeholder="by Text/Salary/Manager" style="font-size: 16px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; text-align: center; box-sizing: border-box; width: 100%;"/>
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" CssClass="gridview"></asp:GridView>
        </div>
    </form>
</body>
</html>