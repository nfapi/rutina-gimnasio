# Rutina Gym

App web para registrar entrenamientos, pesos e historial por rutina. Usa Supabase para las cuentas y la sincronización privada; la app estática se puede publicar en GitHub Pages.

## Configurar Supabase

Antes de publicar, crea un proyecto Supabase y configura la tabla, las políticas de acceso y las credenciales públicas siguiendo la [guía de configuración](./SETUP.md). Ejecuta [`supabase-schema.sql`](./supabase-schema.sql) en el SQL Editor de Supabase.

La app necesita `supabase-config.js` junto a `index.html`. El archivo parte de [`supabase-config.js.example`](./supabase-config.js.example) y debe contener la Project URL y la Publishable key (o la clave `anon` heredada). Son claves públicas diseñadas para usarse desde el navegador; la tabla está protegida con RLS. No publiques nunca una `service_role` ni una secret key.

## Publicar en GitHub Pages

1. En GitHub, abre **Settings → Pages** del repositorio y elige **Deploy from a branch**. Selecciona la rama que publica el sitio y la carpeta `/ (root)`, luego guarda.
2. Confirma que `index.html` y `supabase-config.js` estén en la raíz de la fuente publicada. Como `supabase-config.js` está excluido por `.gitignore`, para agregarlo al repositorio por primera vez usa:

   ```powershell
   git add -f supabase-config.js
   git commit -m "Configure Supabase for GitHub Pages"
   git push
   ```

   Solo agrega la Project URL y la clave Publishable/`anon` al archivo. No incluyas credenciales secretas. Si prefieres no guardar ni la clave pública en el repositorio, configura un workflow de GitHub Actions para generar `supabase-config.js` durante el deploy a partir de una Actions Variable.
3. Espera a que termine el despliegue y abre la URL de Pages. Para un repositorio de proyecto suele ser `https://<usuario-o-organizacion>.github.io/<nombre-del-repositorio>/`; para un repositorio de usuario u organización, suele ser `https://<usuario-o-organizacion>.github.io/`.
4. En Supabase, abre **Authentication → URL Configuration**:
   - Configura **Site URL** con la URL exacta publicada, incluyendo el subdirectorio del repositorio si es un sitio de proyecto. Por ejemplo: `https://nfapi.github.io/rutina-gimnasio/`.
   - Agrega esa URL a **Redirect URLs**. Para permitir las rutas bajo el subdirectorio, agrega también el patrón `https://nfapi.github.io/rutina-gimnasio/**`. Sustituye dominio y nombre del repositorio por los de tu sitio.
   - Conserva las URLs locales que uses para desarrollo, por ejemplo `http://localhost:5500/**`.
5. En GitHub Pages, confirma que **Enforce HTTPS** esté activado. Abre el sitio publicado y prueba crear una cuenta, confirmar el correo y usar **Olvidé mi contraseña**. Los enlaces regresan a la URL configurada en Supabase.

La app requiere internet para cargar el cliente de Supabase desde jsDelivr. No abras `index.html` como `file://`; prueba en localhost o en el sitio HTTPS publicado.
