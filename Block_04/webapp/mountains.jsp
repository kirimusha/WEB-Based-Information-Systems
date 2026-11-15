<%@ page contentType="application/json; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.sql.*" %>
<%
    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/mountain_trekking",
        "kirimusha",
        System.getenv("DB_PASSWORD")
    );

    PreparedStatement st = con.prepareStatement(
        "SELECT mname, mheight, mcountry FROM mountains WHERE mcountry ILIKE ?"
    );
    st.setString(1, "%" + request.getParameter("country") + "%");

    ResultSet rs = st.executeQuery();

    String separator = "";
    out.print("[");

    while (rs.next()) {
        out.print(separator);
        out.print("{\"name\":\"" + rs.getString("mname")
            + "\",\"height\":" + rs.getInt("mheight")
            + ",\"country\":\"" + rs.getString("mcountry") + "\"}");
        separator = ",";
    }

    out.print("]");

    rs.close();
    st.close();
    con.close();
%>
