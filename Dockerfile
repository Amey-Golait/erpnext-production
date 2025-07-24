FROM frappe/erpnext:v15.20.1

USER root
WORKDIR /workspace

# Copy everything into the container
COPY --chown=frappe:frappe . /workspace

# Ensure the script is executable
RUN chmod +x /workspace/entrypoint.sh

USER frappe

# Install Python dependencies (including editable installs for custom apps)
RUN pip install --no-cache-dir -r requirements.txt

# When the container starts, run your entrypoint script
ENTRYPOINT ["/bin/bash", "/workspace/entrypoint.sh"]
