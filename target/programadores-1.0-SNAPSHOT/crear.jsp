<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar Programador</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
Connection con = null;
PreparedStatement ps = null;
%>


    <%
    if (request.getParameter("Guardar") != null) {
        String nombre = request.getParameter("nombre");
        String lenguajeD = request.getParameter("lenguajeD");
        int lenguajeC = Integer.parseInt(request.getParameter("lenguajeC"));
        int estudiante = request.getParameter("estudiante") != null ? 1 : 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/programadores", "root", "");

            String sql = "INSERT INTO tblprogramadores (nombre, lenguajeD, lenguajeC, estudiante) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, lenguajeD);
            ps.setInt(3, lenguajeC);
            ps.setInt(4, estudiante);

            ps.executeUpdate();
            con.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            out.println("Error al guardar los datos: " + e.getMessage());
        }
    }
    %>
</div>
</body>
</html>
