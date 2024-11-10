import platform
import os
import socket
import psutil

# Gather basic system information
def get_system_info():
    info = {
        "Hostname": socket.gethostname(),
        "IP Address": socket.gethostbyname(socket.gethostname()),
        "OS": platform.system(),
        "OS Version": platform.version(),
        "Architecture": platform.machine(),
        "CPU Cores": psutil.cpu_count(),
        "Memory": f"{round(psutil.virtual_memory().total / (1024**3))} GB",
    }
    return info

# Display system information
def display_system_info():
    info = get_system_info()
    print("System Information Audit:")
    for key, value in info.items():
        print(f"{key}: {value}")

if __name__ == "__main__":
    display_system_info()
