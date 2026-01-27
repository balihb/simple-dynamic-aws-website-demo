import random

JOKES = [
    "I only know 25 letters of the alphabet. I don't know y.",
    "Why don't eggs tell jokes? They'd crack each other up.",
    "I used to play piano by ear, but now I use my hands.",
    "Why did the scarecrow win an award? Because he was outstanding in his field.",
    "I'm reading a book about anti-gravity. It's impossible to put down.",
]


def handler(event, context):
    joke = random.choice(JOKES)
    return {
        "statusCode": 200,
        "headers": {
            "content-type": "text/plain; charset=utf-8",
            "cache-control": "no-store",
        },
        "body": joke,
    }
