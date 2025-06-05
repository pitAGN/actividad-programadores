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

<div class="container mt-5">
    <h2>Formulario Programador</h2>
    <form method="post" action="crear.jsp">
        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" id="nombre" required>
        </div>
        <div class="mb-3">
            <label for="lenguajeD" class="form-label">Lenguaje que domina</label>
            <input type="text" class="form-control" name="lenguajeD" id="lenguajeD" required>
        </div>
        <div class="mb-3">
            <label for="lenguajeC" class="form-label">Cantidad de lenguajes que conoce</label>
            <input type="number" class="form-control" name="lenguajeC" id="lenguajeC" required>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="estudiante" name="estudiante" value="1">
            <label class="form-check-label" for="estudiante">Estudiante</label>
        </div>
        <button type="submit" class="btn btn-primary" name="Guardar">Guardar</button>
    </form>

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
