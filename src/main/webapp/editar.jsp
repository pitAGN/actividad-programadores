<%@page import="dao.ProgramadorDAO" %>
<%@page import="modelo.Programador" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ProgramadorDAO dao = new ProgramadorDAO();
    Programador p = dao.obtenerPorId(id);

    if (request.getMethod().equalsIgnoreCase("POST")) {
        p.setNombre(request.getParameter("nombre"));
        p.setLenguajeD(request.getParameter("lenguajeD"));
        p.setLenguajeC(Integer.parseInt(request.getParameter("lenguajeC")));
        p.setPassword(request.getParameter("password"));
        p.setEstudiante(request.getParameter("estudiante") != null ? 1 : 0);
        dao.actualizar(p);
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Programador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h1>Editar Programador</h1>
    <form method="post">
        <div class="mb-3">
            <label>Nombre</label>
            <input name="nombre" class="form-control" value="<%= p.getNombre() %>">
        </div>
        <div class="mb-3">
            <label>Lenguaje Dominante</label>
            <input name="lenguajeD" class="form-control" value="<%= p.getLenguajeD() %>">
        </div>
        <div class="mb-3">
            <label>Cantidad de Lenguajes</label>
            <input name="lenguajeC" type="number" class="form-control" value="<%= p.getLenguajeC() %>">
        </div>
        <div class="mb-3">
            <label>Password</label>
            <input name="password" class="form-control" value="<%= p.getPassword() %>">
        </div>
        <div class="form-check mb-3">
            <input class="form-check-input" type="checkbox" name="estudiante" <%= p.getEstudiante() == 1 ? "checked" : "" %>>
            <label class="form-check-label">Estudiante</label>
        </div>
        <button type="submit" class="btn btn-primary">Actualizar</button>
    </form>
</body>
</html>
