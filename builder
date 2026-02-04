<!-- BEGIN ULTIMATE RESPONSIVE CSS BUILDER -->
<div id="ultimateEditor" style="position: fixed; top:0; right:0; width: 380px; height: 100%; background: #f7f7f7; border-left: 2px solid #ccc; overflow-y: auto; padding: 15px; z-index:9999; font-family: Arial, sans-serif;">
  <h2>Ultimate Responsive CSS Builder</h2>

  <label>Element
    <select id="ueElement">
      <option value="header">header</option>
      <option value=".TopNav a">TopNav links</option>
      <option value=".cta-button">CTA knop</option>
      <option value="footer">footer</option>
      <option value=".mainContentHoofdPagina">Hoofd content</option>
      <option value=".contentWrapper">Content wrapper</option>
      <option value=".contentImg">Content img 1</option>
      <option value=".contentImg2">Content img 2</option>
      <option value="body">body</option>
    </select>
  </label>

  <hr>
  <h3>Box & Layout</h3>
  <label>Background Color<input type="color" id="ueBgColor"></label>
  <label>Opacity<input type="number" id="ueOpacity" min="0" max="1" step="0.05"></label>
  <label>Padding<input type="number" id="uePadding"></label>
  <label>Margin<input type="number" id="ueMargin"></label>
  <label>Border Width<input type="number" id="ueBorderWidth"></label>
  <label>Border Color<input type="color" id="ueBorderColor"></label>
  <label>Border Radius<input type="number" id="ueBorderRadius"></label>
  <label>Box Shadow<input type="text" id="ueBoxShadow" placeholder="10px 10px 20px rgba(0,0,0,0.3)"></label>

  <h3>Text</h3>
  <label>Font Family
    <select id="ueFontFamily">
      <option value="Arial, sans-serif">Arial</option>
      <option value="Verdana, sans-serif">Verdana</option>
      <option value="'Times New Roman', serif">Times New Roman</option>
      <option value="Courier New, monospace">Courier New</option>
    </select>
  </label>
  <label>Font Size<input type="number" id="ueFontSize"></label>
  <label>Font Weight
    <select id="ueFontWeight">
      <option value="normal">Normal</option>
      <option value="bold">Bold</option>
      <option value="lighter">Lighter</option>
    </select>
  </label>
  <label>Text Color<input type="color" id="ueTextColor"></label>
  <label>Text Align
    <select id="ueTextAlign">
      <option value="left">Left</option>
      <option value="center">Center</option>
      <option value="right">Right</option>
    </select>
  </label>
  <label>Letter Spacing<input type="number" id="ueLetterSpacing" step="0.5"></label>
  <label>Line Height<input type="number" id="ueLineHeight" step="0.1"></label>

  <h3>Size & Position</h3>
  <label>Width<input type="number" id="ueWidth"></label>
  <label>Height<input type="number" id="ueHeight"></label>
  <label>Z-Index<input type="number" id="ueZIndex"></label>

  <h3>Hover Effects</h3>
  <label>Hover Background Color<input type="color" id="ueHoverBgColor"></label>
  <label>Hover Text Color<input type="color" id="ueHoverTextColor"></label>
  <label>Hover Box Shadow<input type="text" id="ueHoverBoxShadow"></label>
  <label>Hover Transform
    <select id="ueHoverTransform">
      <option value="none">None</option>
      <option value="scale(1.05)">Scale 1.05</option>
      <option value="scale(1.1)">Scale 1.1</option>
      <option value="rotate(5deg)">Rotate 5°</option>
      <option value="rotate(-5deg)">Rotate -5°</option>
    </select>
  </label>

  <h3>Transition</h3>
  <label>Transition Duration (s)<input type="number" id="ueTransition" step="0.1" value="0.3"></label>

  <button id="ueCopyCSS" style="margin-top:10px;">Copy CSS</button>
  <button id="ueReset" style="margin-top:10px;">Reset</button>

  <h3>Generated CSS:</h3>
  <pre id="ueGeneratedCSS" style="background:#eee;padding:10px;white-space:pre-wrap;"></pre>
</div>

<script>
const ueElement = document.getElementById('ueElement');
let selectedEls = [], currentElement = null;

// Inputs
const inputs = {
  bgColor: document.getElementById('ueBgColor'),
  opacity: document.getElementById('ueOpacity'),
  padding: document.getElementById('uePadding'),
  margin: document.getElementById('ueMargin'),
  borderWidth: document.getElementById('ueBorderWidth'),
  borderColor: document.getElementById('ueBorderColor'),
  borderRadius: document.getElementById('ueBorderRadius'),
  boxShadow: document.getElementById('ueBoxShadow'),
  fontFamily: document.getElementById('ueFontFamily'),
  fontSize: document.getElementById('ueFontSize'),
  fontWeight: document.getElementById('ueFontWeight'),
  textColor: document.getElementById('ueTextColor'),
  textAlign: document.getElementById('ueTextAlign'),
  letterSpacing: document.getElementById('ueLetterSpacing'),
  lineHeight: document.getElementById('ueLineHeight'),
  width: document.getElementById('ueWidth'),
  height: document.getElementById('ueHeight'),
  zIndex: document.getElementById('ueZIndex'),
  hoverBgColor: document.getElementById('ueHoverBgColor'),
  hoverTextColor: document.getElementById('ueHoverTextColor'),
  hoverBoxShadow: document.getElementById('ueHoverBoxShadow'),
  hoverTransform: document.getElementById('ueHoverTransform'),
  transition: document.getElementById('ueTransition')
};

const ueGeneratedCSS = document.getElementById('ueGeneratedCSS');

// --- Helpers ---
function rgbToHex(rgb){
  const r = rgb.match(/\d+/g);
  if(!r) return "#ffffff";
  return "#" + r.slice(0,3).map(x=>parseInt(x).toString(16).padStart(2,'0')).join('');
}

// --- Select element ---
function selectElement(){
  selectedEls = document.querySelectorAll(ueElement.value);
  if(!selectedEls.length) return;
  currentElement = selectedEls[0];
  const style = window.getComputedStyle(currentElement);

  inputs.bgColor.value = rgbToHex(style.backgroundColor);
  inputs.opacity.value = parseFloat(style.opacity);
  inputs.padding.value = parseInt(style.paddingTop);
  inputs.margin.value = parseInt(style.marginTop);
  inputs.borderWidth.value = parseInt(style.borderTopWidth);
  inputs.borderColor.value = rgbToHex(style.borderColor);
  inputs.borderRadius.value = parseInt(style.borderRadius);
  inputs.boxShadow.value = style.boxShadow;

  inputs.fontFamily.value = style.fontFamily.replace(/"/g,"");
  inputs.fontSize.value = parseInt(style.fontSize);
  inputs.fontWeight.value = style.fontWeight;
  inputs.textColor.value = rgbToHex(style.color);
  inputs.textAlign.value = style.textAlign;
  inputs.letterSpacing.value = parseFloat(style.letterSpacing);
  inputs.lineHeight.value = parseFloat(style.lineHeight);

  inputs.width.value = parseInt(style.width);
  inputs.height.value = parseInt(style.height);
  inputs.zIndex.value = parseInt(style.zIndex);

  inputs.transition.value = 0.3;

  makeDraggable(currentElement);
  generateCSS();
}

// --- Apply styles ---
function applyStyles(){
  if(!currentElement) return;
  const el = currentElement;

  el.style.backgroundColor = inputs.bgColor.value;
  el.style.opacity = inputs.opacity.value;
  el.style.padding = inputs.padding.value+'px';
  el.style.margin = inputs.margin.value+'px';
  el.style.border = inputs.borderWidth.value+'px solid '+inputs.borderColor.value;
  el.style.borderRadius = inputs.borderRadius.value+'px';
  el.style.boxShadow = inputs.boxShadow.value;

  el.style.fontFamily = inputs.fontFamily.value;
  el.style.fontSize = inputs.fontSize.value+'px';
  el.style.fontWeight = inputs.fontWeight.value;
  el.style.color = inputs.textColor.value;
  el.style.textAlign = inputs.textAlign.value;
  el.style.letterSpacing = inputs.letterSpacing.value+'px';
  el.style.lineHeight = inputs.lineHeight.value;

  el.style.width = inputs.width.value+'px';
  el.style.height = inputs.height.value+'px';
  el.style.zIndex = inputs.zIndex.value;
  el.style.transition = 'all '+inputs.transition.value+'s ease';

  el.onmouseover = () => {
    el.style.backgroundColor = inputs.hoverBgColor.value || el.style.backgroundColor;
    el.style.color = inputs.hoverTextColor.value || el.style.color;
    el.style.boxShadow = inputs.hoverBoxShadow.value || el.style.boxShadow;
    el.style.transform = inputs.hoverTransform.value;
  };
  el.onmouseout = () => {
    el.style.backgroundColor = inputs.bgColor.value;
    el.style.color = inputs.textColor.value;
    el.style.boxShadow = inputs.boxShadow.value;
    el.style.transform = 'none';
  };

  generateCSS();
}

// --- Drag & drop responsive ---
function makeDraggable(el){
  let offsetX, offsetY, isDragging=false;
  const parent = el.parentElement;
  const parentRect = parent.getBoundingClientRect();

  el.style.cursor='grab';
  el.onmousedown = function(e){
    e.preventDefault();
    isDragging=true;
    el.style.cursor='grabbing';

    const rect = el.getBoundingClientRect();
    el.style.position='absolute';
    el.style.left = ((rect.left-parentRect.left)/parentRect.width*100)+'%';
    el.style.top = ((rect.top-parentRect.top)/parentRect.height*100)+'%';

    offsetX = e.clientX - rect.left;
    offsetY = e.clientY - rect.top;

    function move(e){
      if(!isDragging) return;
      let x = e.clientX - offsetX - parentRect.left;
      let y = e.clientY - offsetY - parentRect.top;

      el.style.left = ((x/parentRect.width)*100).toFixed(2)+'%';
      el.style.top = ((y/parentRect.height)*100).toFixed(2)+'%';
      generateCSS();
    }
    function stopDrag(){
      isDragging=false;
      el.style.cursor='grab';
      document.removeEventListener('mousemove',move);
      document.removeEventListener('mouseup',stopDrag);
    }
    document.addEventListener('mousemove',move);
    document.addEventListener('mouseup',stopDrag);
  }
}

// --- Generate responsive CSS ---
function generateCSS(){
  if(!currentElement) return;
  const el = currentElement;

  // breakpoints
  const breakpoints = {
    desktop: 1024,
    tablet: 768,
    mobile: 0
  };

  let css = '';

  // --- Desktop ---
  css += `/* Desktop */\n`;
  css += `${ueElement.value} {\n`;
  css += `  position:absolute;\n  left:${el.style.left};\n  top:${el.style.top};\n`;
  css += `  width:${inputs.width.value}px;\n  height:${inputs.height.value}px;\n`;
  css += `  z-index:${inputs.zIndex.value};\n`;
  css += `  background-color:${inputs.bgColor.value};\n  color:${inputs.textColor.value};\n`;
  css += `  font-family:${inputs.fontFamily.value};\n  font-size:${inputs.fontSize.value}px;\n`;
  css += `  font-weight:${inputs.fontWeight.value};\n`;
  css += `  padding:${inputs.padding.value}px;\n  margin:${inputs.margin.value}px;\n`;
  css += `  border:${inputs.borderWidth.value}px solid ${inputs.borderColor.value};\n`;
  css += `  border-radius:${inputs.borderRadius.value}px;\n`;
  css += `  box-shadow:${inputs.boxShadow.value};\n`;
  css += `  text-align:${inputs.textAlign.value};\n  letter-spacing:${inputs.letterSpacing.value}px;\n  line-height:${inputs.lineHeight.value};\n`;
  css += `  transition: all ${inputs.transition.value}s ease;\n`;
  css += `}\n`;
  css += `${ueElement.value}:hover {\n`;
  css += `  background-color:${inputs.hoverBgColor.value};\n  color:${inputs.hoverTextColor.value};\n`;
  css += `  box-shadow:${inputs.hoverBoxShadow.value};\n  transform:${inputs.hoverTransform.value};\n`;
  css += `}\n`;

  // --- Tablet ---
  css += `@media(max-width:1023px) and (min-width:768px){\n`;
  css += `  ${ueElement.value} {\n  left:${el.style.left}; top:${el.style.top}; }\n}\n`;

  // --- Mobile ---
  css += `@media(max-width:767px){\n`;
  css += `  ${ueElement.value} {\n  left:${el.style.left}; top:${el.style.top}; }\n}\n`;

  ueGeneratedCSS.textContent = css;
}

// --- Event listeners ---
ueElement.addEventListener('change', selectElement);
Object.values(inputs).forEach(i => i.addEventListener('input', applyStyles));
document.getElementById('ueCopyCSS').addEventListener('click', ()=>{
  navigator.clipboard.writeText(ueGeneratedCSS.textContent);
  alert('CSS gekopieerd!');
});
document.getElementById('ueReset').addEventListener('click', ()=>location.reload());
</script>
<!-- END ULTIMATE RESPONSIVE CSS BUILDER -->
