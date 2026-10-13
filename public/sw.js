const CACHE='checkobra-v2-5-static-1';
self.addEventListener('install',e=>e.waitUntil(caches.open(CACHE).then(c=>c.addAll(['/','/index.html','/styles.css','/app.js','/assets/logo-aitue.png','/assets/A05.jpg','/assets/A06.jpg'])).then(()=>self.skipWaiting())));
self.addEventListener('activate',e=>e.waitUntil(self.clients.claim()));
self.addEventListener('fetch',e=>{const u=new URL(e.request.url);if(e.request.method!=='GET'||u.origin!==self.location.origin||u.pathname.startsWith('/config.js'))return;e.respondWith(fetch(e.request).then(r=>{if(r.ok&&['document','script','style','image'].includes(e.request.destination)){const c=r.clone();caches.open(CACHE).then(x=>x.put(e.request,c));}return r}).catch(()=>caches.match(e.request)))});
