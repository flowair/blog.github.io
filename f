强调一点，JAVA下写代码必须要用try catch不然就会出现各种各样的错误！！写try catch是个好习惯。。
 
而且在使用之前要把Oracle 11g的jar包给引进来。build path---add externdal jars..
 
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException; 
import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;

public class conorcl {
 
 
 private static final String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String DBURL = "jdbc:oracle:thin:@127.0.0.1:1521:BUS";
 private static final String DBUSER = "manage_bus";
 private static final String DBPASSWORD = "its312";
    private static Connection conn;
 

 public static void main(String[] args) {
  // TODO Auto-generated method stub

  try
  {
   DBCon();
   System.out.println(conn);
  
   Statement stmt = conn.createStatement();
   String querystr="select * from gps t where longitude>113.363769 " +
     "and " +
     "longitude<113.400545 " +
     "and " +
     "latitude>23.040930 " +
     "and " +
     "latitude<23.067629 " +
     "and " +
     "obutime<to_date('2010-6-29 00:01:00','YYYY-MM-DD-HH24:MI:SS')";
   ResultSet rs = stmt.executeQuery(querystr);
       
   System.out.println("query is finished");
   if(rs!=null)
   {
    System.out.println("there is data");
    while(rs.next())
    {
     double longi=rs.getDouble("longitude");
     double lat=rs.getDouble("latitude");
     double sum=longi+lat;
     
     System.out.print(rs.getString("longitude")+"\t");
     System.out.print(rs.getString("latitude")+"\t");
     System.out.println(String.valueOf(sum));  
    }
   }
   
   String sqlInsert="insert into test_can values('hadoop','hadoop','hadoop')";
   int result = stmt.executeUpdate(sqlInsert);
   if(result!=0){
    System.out.println("insert成功");
   }
   
   rs.close();
   stmt.close();
   conn.close();
  }
  catch(Exception e) {
   e.printStackTrace();
  }
 
 }
 
 public static void DBCon() {
  try {
   Class.forName(DBDRIVER);
  
   conn = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
  } catch (Exception e) {
  }
  }
  
 
  
 public  void DBClose() {
  try {
   conn.close();
  
  } catch (Exception e) {
   e.printStackTrace();
  }
  }
}
