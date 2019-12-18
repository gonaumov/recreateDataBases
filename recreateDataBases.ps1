# Add MySQL Data Connector
[void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data")
$tablesForRecreation = @("first_database", "second_database")

$total = ''
$tablesForRecreation | ForEach-Object {   
$total = -join(
     $total,  
    'DROP DATABASE IF EXISTS `',
     $_,
    '`;',
    'CREATE DATABASE `',
    $_,
    '` ',
    ' CHARACTER SET utf8 COLLATE utf8_general_ci;')
} 

# Open Connection to SQL Server
$connStr = "server=127.0.0.1;port=3306;uid=root;pwd=root"
$conn = New-Object MySql.Data.MySqlClient.MySqlConnection($connStr)
$conn.Open()

$cmd = New-Object MySql.Data.MySqlClient.MySqlCommand($total, $conn)
$da = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($cmd)
$ds = New-Object System.Data.DataSet
$da.Fill($ds)

Write-Host "All done!!!"
Write-Host "Press any key to continue..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null