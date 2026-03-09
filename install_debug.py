import subprocess
import sys

with open('requirements.txt', 'r') as f:
    packages = [line.strip() for line in f if line.strip() and not line.startswith('#')]

for pkg in packages:
    print(f"Installing {pkg}...")
    result = subprocess.run([r"venv_311\Scripts\pip.exe", "install", pkg], capture_output=True, text=True)
    if result.returncode != 0:
        print(f"FAILED on {pkg}:")
        print(result.stderr)
        sys.exit(1)
        
print("All packages installed successfully!")
