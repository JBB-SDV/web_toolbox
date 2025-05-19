import sys
import subprocess

def main():

    if len(sys.argv) != 2:
        print("Usage: python script.py <argument>")
        sys.exit(1)
    
    print(f"Ceci est le mode non SIE")

if __name__ == "__main__":
    main()
