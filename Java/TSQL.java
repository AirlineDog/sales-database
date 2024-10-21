import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class TSQL {
    private static String dbURL = "Your_jdbc_credentials";

	private static Connection conn;

	private static Statement stmt;

    /* Initiates a connection with the database */
    public void createDBConnection(){
        try {
			// Microsoft Server Driver
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
			// Get a connection
			conn = DriverManager.getConnection(dbURL);
			System.out.println("Database connection created");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }

	/* Deletes an indicated customer from the database */
	public void deleteCustomer() {

		createDBConnection();

		Scanner in = new Scanner(System.in);

		System.out.println("Enter Customer_Code for deletion :");
		int cust_code = in.nextInt();
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate("DELETE FROM Customer " + "WHERE Customer_Code = " + cust_code);
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		in.close();
	}

    /* Takes an Order_Code and prints corresponding receipt */
	public void printReceipt() {

		createDBConnection();

		Scanner in = new Scanner(System.in);
		System.out.println("Enter Order_Code :");
		int orderCode = in.nextInt();
		try {
			stmt = conn.createStatement();

			// desired sql query
			ResultSet result = stmt.executeQuery(
					"SELECT c.Name, o.Order_Date, o.Sent_Date, con.Product_Code, p.Description, p.Price, con.Quantity, SUM(p.Price * con.Quantity) AS Total_Price "
							+ "FROM [Order] AS o, Consists AS con, Customer AS c, Product as p "
							+ "WHERE o.Order_Code = " + orderCode + " " + "AND o.Order_Code = con.Order_Code "
							+ "AND c.Customer_Code = o.Customer_Code " + "AND p.Product_Code = con.Product_Code "
							+ "GROUP BY c.Name, o.Order_Date, o.Sent_Date, con.Product_Code, p.Description, p.Price, con.Quantity");

			ResultSetMetaData rsmd = result.getMetaData(); 
			int numberCols = rsmd.getColumnCount();

			// output format
			System.out.println(
					"\n---------------------------------------" + "--------------------------------------------------"
							+ "--------------------------------------------------"
							+ "-----------------------------------------------");
			for (int i = 1; i <= numberCols; i++) {
				// print Column Names
				System.out.printf("%-25s", rsmd.getColumnLabel(i));
			}
			System.out.println(
					"\n----------------------------------------" + "---------------------------------------------------"
							+ "---------------------------------------------------"
							+ "--------------------------------------------");

			while (result.next()) {
				String name = result.getString(1);
				String orderDate = result.getString(2);
				String sentDate = result.getString(3);
				int prodCode = result.getInt(4);
				String desc = result.getString(5);
				double price = result.getDouble(6);
				int quantity = result.getInt(7);
				double totalPrice = result.getDouble(8);

				System.out.printf("%-25s%-25s%-25s%-25s%-25s%-25s%-25s%-25s\n", name, orderDate, sentDate, prodCode,
						desc, price, quantity, totalPrice);

			}
			result.close();
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		in.close();
	}
}
