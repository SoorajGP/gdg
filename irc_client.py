import socket
import threading
from datetime import datetime

SERVER = "irc.libera.chat"
PORT = 6667
CHANNEL = "#testchannel"
NICK = "SoorajBot123"
REALNAME = "Sooraj"

RESET = "\033[0m"
GREEN = "\033[92m"
CYAN = "\033[96m"
YELLOW = "\033[93m"


def receive_messages(sock):
    while True:
        try:
            message = sock.recv(2048).decode("utf-8")
            timestamp=datetime.now().strftime("%H:%M:%S")
            print(f"[{timestamp}] {message}")

            if message.startswith("PING"):
                sock.sendall(f"PONG {message.split()[1]}\r\n".encode())

            if "PRIVMSG" in message:
                print(f"{GREEN}{message}{RESET}")
            elif "PING" in message:
                print(f"{YELLOW}{message}{RESET}")
            else:
                print(f"{CYAN}{message}{RESET}")

        except:
            print("Disconnected from server.")
            break


def send_messages(sock):
    while True:
        msg = input()

        if msg.startswith("/quit"):
            sock.sendall(b"QUIT\r\n")
            print("Quitting...")
            break

        elif msg.startswith("/join"):
            parts = msg.split()
            if len(parts) > 1:
                channel = parts[1]
                sock.sendall(f"JOIN {channel}\r\n".encode())

        else:
            sock.sendall(f"PRIVMSG {CHANNEL} :{msg}\r\n".encode())


def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((SERVER, PORT))

    sock.sendall(f"NICK {NICK}\r\n".encode())
    sock.sendall(f"USER {NICK} 0 * :{REALNAME}\r\n".encode())
    sock.sendall(f"JOIN {CHANNEL}\r\n".encode())

    recv_thread = threading.Thread(target=receive_messages, args=(sock,))
    send_thread = threading.Thread(target=send_messages, args=(sock,))

    recv_thread.start()
    send_thread.start()


if __name__ == "__main__":
    main()
