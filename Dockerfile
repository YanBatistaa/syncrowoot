FROM chatwoot/chatwoot:latest

# Voltamos para root temporariamente para garantir que os comandos de edição funcionem
USER root

# 1. Aplicamos o patch nos arquivos que REALMENTE existem na imagem base
# O erro "No such file" ocorreu porque o caminho ou o arquivo global_config.rb mudou
RUN sed -i 's/def enterprise?.*/def enterprise?; true; end/g' app/models/account.rb && \
    sed -i 's/def feature_enabled?.*/def feature_enabled?(_feature); true; end/g' app/models/account.rb || true

# 2. Em vez de tentar usar o nome "chatwoot:chatwoot" (que deu erro de unknown user), 
# vamos garantir que a pasta /app pertença ao usuário que rodará o processo final.
# Muitas imagens usam o UID 1000.
RUN chown -R 1000:1000 /app || true

# 3. Retornamos para o usuário padrão para segurança
USER 1000
