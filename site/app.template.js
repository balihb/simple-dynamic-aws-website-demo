const API_URL = "${api_url}";
const TIMEOUT_MS = 4000;

const ERROR_JOKES = [
  "Well, this is awkward… the joke machine tripped over a power cable.",
  "I would tell you a joke about errors, but it didn’t quite land.",
  "Something went wrong, but at least my sense of humor is still working.",
  "I tried to fetch a joke, but it ghosted me.",
  "Dad joke failed successfully.",
];

function randomErrorJoke() {
  return ERROR_JOKES[Math.floor(Math.random() * ERROR_JOKES.length)];
}

function setOutput(text, cssClass) {
  const out = document.getElementById("out");
  out.className = cssClass;
  out.textContent = text;
}

document.getElementById("btn").addEventListener("click", async (e) => {
  const btn = e.target;
  btn.disabled = true;

  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), TIMEOUT_MS);

  try {
    setOutput("Thinking of a dad joke...", "loading");

    const r = await fetch(API_URL, {
      cache: "no-store",
      signal: controller.signal,
    });

    if (!r.ok) throw new Error("Request failed");

    const joke = await r.text();
    setOutput(joke, "success");
  } catch {
    setOutput(randomErrorJoke(), "error");
  } finally {
    clearTimeout(timeout);
    btn.disabled = false;
  }
});
