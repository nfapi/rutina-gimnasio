# Configuración inicial

La app usa Supabase para autenticación y sincronización privada. El plan Free incluye Auth y Postgres; actualmente limita la base a 500 MB y pausa proyectos sin actividad durante una semana. Consulta [los límites vigentes](https://supabase.com/pricing).

## Crear y conectar el proyecto

1. Crea un proyecto gratuito en [Supabase](https://supabase.com/dashboard) y espera a que termine de aprovisionarse.
2. En **SQL Editor**, ejecuta el contenido de [`supabase-schema.sql`](./supabase-schema.sql). La tabla guarda un documento JSON por usuario y las políticas RLS impiden que cada usuario consulte o cambie datos ajenos.
3. Copia `supabase-config.js.example` como `supabase-config.js` y completa `url` y `anonKey` con los valores de **Project URL** y **Publishable key** (o la clave `anon` heredada) de **Project Settings → API**.
   - En PowerShell: `Copy-Item supabase-config.js.example supabase-config.js`
   - `supabase-config.js` está excluido de Git. La clave publicable/anon puede estar en el navegador; **nunca** uses `service_role` ni una secret key.
4. En **Authentication → URL Configuration**, agrega la URL donde ejecutarás la app a **Site URL** y a **Redirect URLs** (por ejemplo, `http://localhost:5500/**` si usas Live Server).
5. Sirve `index.html` por HTTP/HTTPS, por ejemplo con la extensión Live Server de VS Code. No la abras como `file://`: los enlaces de confirmación y recuperación necesitan una URL permitida. La app también necesita internet para cargar el cliente de Supabase desde jsDelivr.
6. Abre la app, crea tu cuenta y confirma el correo si Supabase lo solicita. La opción **Olvidé mi contraseña** enviará un enlace a la misma URL configurada.

Si todavía no hay datos remotos, la app migra el historial local antiguo a la primera cuenta que inicia sesión en ese navegador; la migración queda marcada para no copiar datos de una cuenta a otra. Después, cada usuario mantiene su propio documento sincronizado. Si el respaldo que quieres recuperar está en un archivo JSON, usa **Importar JSON** después de entrar.

La rutina inicial se obtiene del plan que ya trae la app y se guarda junto con la cuenta. En **Rutinas** puedes crear varios planes, editar días, bloques, ejercicios, series, repeticiones, peso inicial, incrementos, videos y observaciones. También puedes importar/exportar una rutina individual en JSON; el respaldo general incluye tanto rutinas como historial.

Para entrenar, abre el día y pulsa **Empezar entrenamiento**. Marca los ejercicios y ajusta los pesos durante la sesión; el progreso en curso se conserva si cierras o recargas la app. Al pulsar **Finalizar y guardar**, se registra una sesión con fecha, día, ejercicios y pesos, y el plan queda limpio para volver a iniciarlo, incluso otra vez el mismo día. La rutina base no cambia con los pesos de una sesión. El historial muestra cargas recientes y sugiere considerar un aumento cuando se repite el mismo peso, siempre que hayas completado series y repeticiones con buena técnica.
