# ft_server

Proyecto escuela 42
Instrucciones generales
 • Tiene que entregar todos los archivos necesarios para la configuración de su servidor en un directorio srcs. 
 • Su archivo Dockerfile tendrá que estar en la raíz de su repositorio. Se usará para construir su contenedor. No puede usar docker-compose.
 • Todos los archivos necesarios para su wordpress tendrán que estar en el directorio srcs. 

Parte obligatoria 
• Tendrá que instalar un servidor web con Nginx, dentro de un solo contenedor Docker. El contenedor tendrá que funcionar sobre Debian Buster. 
• Su servidor tendrá que permitir que funcionen varios servicios a la vez. Los servicios serán un Wordpress, que tendrá que instalar Ud. mismo, 
  Phpmyadmin y MySQL. Tendrá que asegurarse de que su base de datos SQL funciona con wordpress y con phpmyadmin.
• Cuando sea posible, su servidor debe poder utilizar el protocolo SSL. 
• Tendrá que asegurarse de que su servidor redirige hacia el sitio web correcto, en función de la url introducida. También se debe asegurar de 
  que su servidor funcione con un índice automático, que se puede desactivar.
  
Para que el ft_server de este repositorio funcione, simplemente hay que montar el dockerfile y ejecutarlo. Para ello hay que ejecutar los siguientes comandos:

  docker build -t ft_server .

  docker run -it -p 80:80 -p 443:443 ft_server

Donde ft_server es el nombre de la imagen, podemos poner el nombre deseado.
