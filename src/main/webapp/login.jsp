<%@page import="dao.ProgramadorDAO" %>
<%@page import="modelo.Programador" %>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String nombre = request.getParameter("nombre");
        String password = request.getParameter("password");

        ProgramadorDAO dao = new ProgramadorDAO();
        Programador p = dao.validarLogin(nombre, password);

        if (p != null) {
            session.setAttribute("logueado", true);
            session.setAttribute("id", p.getId());
            session.setAttribute("nombre", p.getNombre());
            response.sendRedirect("index.jsp");
            return;
        } else {
            request.setAttribute("error", "Credenciales inválidas");
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <%-- Added for better responsiveness --%>
    <title>Iniciar Sesión</title>
    <%-- Bootstrap CSS (ensure this path is correct relative to your project) --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Custom styles (ensure this path is correct relative to your project) --%>
    <link rel="stylesheet" href="style2.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h2>Login</h2>
            <form method="post">
                <div class="form-group mb-3"> <%-- Added Bootstrap class for spacing --%>
                    <input type="text" class="form-control" name="nombre" placeholder="Nombre" required>
                </div>
                <div class="form-group mb-3"> <%-- Added Bootstrap class for spacing --%>
                    <input type="password" class="form-control" name="password" placeholder="Contraseña" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Entrar</button> <%-- w-100 makes button full width --%>
            </form>
            <% if (request.getAttribute("error") != null) { %>
                <p class="error-msg mt-3 text-danger"><%= request.getAttribute("error") %></p> <%-- Added Bootstrap text-danger and mt-3 --%>
            <% } %>
        </div>
    </div>
    <%-- Optional: Bootstrap JS for components if you plan to use them --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>