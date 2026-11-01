import java.sql.*
import groovy.json.JsonOutput

response.setContentType('application/json; charset=UTF-8')
Class.forName('org.postgresql.Driver')
def con = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/mountain_trekking",
    "kirimusha",
    "Katalan11251442\$"
)
def st = con.prepareStatement('SELECT mname, mheight, mcountry FROM mountains WHERE mcountry ILIKE ?')
st.setString(1, '%' + request.getParameter('country') + '%')
def rs = st.executeQuery()
def rows = []
while (rs.next()) {
    rows.add([name: rs.getString('mname'), height: rs.getInt('mheight'), country: rs.getString('mcountry')])
}
rs.close()
st.close()
con.close()
out.print(JsonOutput.toJson(rows))
