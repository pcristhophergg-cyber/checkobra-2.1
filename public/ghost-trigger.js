/* Solo acceso a demostración local. No cambia autenticación ni permisos Supabase. */
(()=>{
  const logo=document.getElementById('aitue-ghost-trigger');
  if(!logo)return;
  let clicks=0,first=0;
  logo.addEventListener('click',()=>{
    const now=Date.now();
    if(now-first>2000){clicks=0;first=now;}
    clicks+=1;
    if(clicks>=3){clicks=0;first=0;window.location.assign('/fantasma.html');}
  });
})();
