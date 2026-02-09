FROM chatwoot/chatwoot:latest

USER root

# Aplica o patch no código-fonte para liberar o modo Enterprise e o Captain AI
RUN sed -i 's/def enterprise?.*/def enterprise?; true; end/g' app/models/account.rb && \
    sed -i 's/def feature_enabled?.*/def feature_enabled?(_feature); true; end/g' app/models/account.rb && \
    sed -i 's/def valid_license?.*/def valid_license?; true; end/g' app/models/global_config.rb || true

# Garante que as permissões de arquivos estejam corretas
RUN chown -R chatwoot:chatwoot /app

USER chatwoot
