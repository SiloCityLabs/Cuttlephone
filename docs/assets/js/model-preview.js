import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { ThreeMFLoader } from 'three/addons/loaders/3MFLoader.js';

const container = document.getElementById('model-preview');
const statusEl = document.getElementById('model-preview-status');
const downloadEl = document.getElementById('model-preview-download');

if (!container) {
  throw new Error('Missing #model-preview container');
}

function setStatus(message) {
  if (statusEl) {
    statusEl.textContent = message;
  }
}

// Only allow a simple basename under /assets/3mf/
function resolveModelFile() {
  const params = new URLSearchParams(window.location.search);
  const requested = params.get('model') || container.dataset.defaultModel || '';
  // strip any path; only the filename is allowed
  const basename = requested.split(/[/\\]/).pop() || '';
  // strict char limit that matches build name
  if (!/^[A-Za-z0-9._+-]+\.3mf$/i.test(basename)) {
    return null;
  }
  return basename;
}

const assetsBase = container.dataset.assetsBase || '/assets/3mf/';
const modelFile = resolveModelFile();
if (!modelFile) {
  setStatus('Missing or invalid model. Use a Preview link from Generated models.');
  throw new Error('Invalid model query parameter');
}

// ensure assetsBase ends with trailing slash
const MODEL_URL = assetsBase.replace(/\/?$/, '/') + modelFile;

if (downloadEl) {
  const link = downloadEl.querySelector('a');
  if (link) {
    link.href = MODEL_URL;
    link.textContent = 'Download ' + modelFile;
  }
  downloadEl.hidden = false;
}

const scene = new THREE.Scene();
scene.background = new THREE.Color(0xf0f0f0);

const camera = new THREE.PerspectiveCamera(45, 1, 0.1, 2000);
camera.position.set(80, 60, 120);

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
container.insertBefore(renderer.domElement, statusEl);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.dampingFactor = 0.08;

scene.add(new THREE.AmbientLight(0xffffff, 0.55));

const keyLight = new THREE.DirectionalLight(0xffffff, 0.9);
keyLight.position.set(80, 120, 60);
scene.add(keyLight);

const fillLight = new THREE.DirectionalLight(0xffffff, 0.35);
fillLight.position.set(-60, 40, -40);
scene.add(fillLight);

function resize() {
  const width = container.clientWidth;
  const height = Math.max(360, Math.round(width * 0.6));
  camera.aspect = width / height;
  camera.updateProjectionMatrix();
  renderer.setSize(width, height);
}

function frameObject(object) {
  // 3MF / CAD models are typically Z-up; three.js is Y-up
  object.rotation.set(-Math.PI / 2, 0, 0);

  const box = new THREE.Box3().setFromObject(object);
  const size = box.getSize(new THREE.Vector3());
  const center = box.getCenter(new THREE.Vector3());
  object.position.sub(center);

  const maxDim = Math.max(size.x, size.y, size.z);
  const fitDist = maxDim / (2 * Math.tan(THREE.MathUtils.degToRad(camera.fov) / 2));
  camera.position.set(fitDist * 0.9, fitDist * 0.6, fitDist * 1.1);
  camera.near = Math.max(0.01, fitDist / 100);
  camera.far = fitDist * 20;
  camera.updateProjectionMatrix();

  controls.target.set(0, 0, 0);
  controls.update();
}

function animate() {
  requestAnimationFrame(animate);
  controls.update();
  renderer.render(scene, camera);
}

resize();
window.addEventListener('resize', resize);
animate();

setStatus('Loading ' + modelFile + '...');

const loader = new ThreeMFLoader();
loader.load(
  MODEL_URL,
  (object) => {
    frameObject(object);
    scene.add(object);
    setStatus(modelFile + ' - drag to orbit, scroll to zoom.');
  },
  (event) => {
    if (!event.total) {
      return;
    }
    const pct = Math.round((100 * event.loaded) / event.total);
    setStatus('Loading ' + modelFile + '... ' + pct + '%');
  },
  (error) => {
    console.error(error);
    setStatus('Failed to load ' + modelFile + '. Is it in the latest release assets?');
  }
);
