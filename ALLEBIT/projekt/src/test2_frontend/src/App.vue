<script setup>
import { onMounted, ref } from 'vue';
import { test2_backend } from 'declarations/test2_backend/index';

const offers = ref([]);
let show_output = false;
let output = "";
let request_status = "";
const isDarkTheme = ref(window.matchMedia('(prefers-color-scheme: dark)').matches);

let offersLoaded = false;

async function handleSubmit(e) {
  e.preventDefault();
  const target = e.target;
  const title = target.querySelector('#new_offer-title').value;
  const description = target.querySelector('#new_offer-description').value;
  const capital = target.querySelector('#new_offer-capital').value;
  const price = target.querySelector('#new_offer-price').value;
  const contact = target.querySelector('#new_offer-contact').value;

  let result = await test2_backend.oferta_add(title, contact, description, capital, price);
  output = result.deb;
  request_status = result.log;
  show_output = true;

  offersLoaded = false;
  await getOffers(25);
}

async function getOffers(n) {
  if (offersLoaded) return;

  const fetchedOffers = [];
  for (let i = 0; i < n; i++) {
    try {
      const offer = await test2_backend.oferta_cek(i);
      fetchedOffers.push(offer);
    } catch (error) {
      console.error(`Error fetching offer ${i}:`, error);
      break;
    }
  }

  offers.value = fetchedOffers.reverse();
  offersLoaded = true;
}

function toggleTheme() {
  isDarkTheme.value = !isDarkTheme.value;
}

onMounted(async () => {
  await getOffers(25);
});
</script>

<template>
  <header :class="{ dark: isDarkTheme }">
    <nav>
      <div class="logo" :class="{ dark: isDarkTheme }"></div>
      <button @click="toggleTheme" class="dot-font" :class="{ dark: isDarkTheme }" style="padding: 7px;">
        <i :class="isDarkTheme ? 'bi bi-moon-fill' : 'bi bi-brightness-high-fill'" aria-label="Toggle Theme"></i>
      </button>
    </nav>
  </header>

  <main :class="{ dark: isDarkTheme }">
    <div v-show="show_output" class="message" :class="`${request_status['OK'] ? 'okMessageStyle' : 'errorMessageStyle'}`">
      {{ output }}
    </div>
    <div class="add-offer">
      <form action="#" @submit="handleSubmit">
        <label class="dot-font">Tytuł</label> <br>
        <input id="new_offer-title" alt="new_offer-title" type="text" required :class="{ dark: isDarkTheme }"> <br>
        <label class="dot-font">Opis</label> <br>
        <textarea id="new_offer-description" alt="new_offer-description" type="text" required :class="{ dark: isDarkTheme }"></textarea> <br>
        <div class="grid-3">
          <div style="margin: 0px 5px 0px 0px;">
            <label class="dot-font">Kapitał</label> <br>
            <input id="new_offer-capital" alt="new_offer-capital" type="text" required :class="{ dark: isDarkTheme }"> <br>
          </div>
          <div style="margin: 0px 5px;">
            <label class="dot-font">Cena</label> <br>
            <input id="new_offer-price" alt="new_offer-price" type="text" required :class="{ dark: isDarkTheme }"> <br>
          </div>
          <div style="margin: 0px 0px 0px 5px;">
            <label class="dot-font">Kontakt</label> <br>
            <input id="new_offer-contact" alt="new_offer-contact" type="text" required :class="{ dark: isDarkTheme }"> <br>
          </div>
        </div>
        <button type="submit" class="dot-font" :class="{ dark: isDarkTheme }">Dodaj ogłoszenie</button>
      </form>
    </div>
    <div v-if="offers.length" class="offers">
      <div v-for="offer in offers" :key="offer.cozaco" class="offer" :class="{ dark: isDarkTheme }">
        <h1 class="dot-font">{{ offer.cozaco }}</h1>
        <p>{{ offer.oferta }}</p>
        <h2>$ {{ offer.kapital }}</h2>
        <h2 class="dot-font">% {{ offer.cena }}</h2>
        <h2># {{ offer.kontakt }}</h2>
      </div>
    </div>
    <div v-else class="wait-container">
      <div class="wait-icon"><i class="bi bi-hourglass-top"></i></div>
      <p class="dot-font wait-label">Czekaj...</p>
    </div>
  </main>
</template>
