# Feature Settings

Esta feature permite que o usuário configure preferências do aplicativo como tema, idioma e moeda.

## Estrutura

```
settings/
├── data/
│   ├── datasources/
│   │   ├── settings_datasource.dart
│   │   └── datasources.dart
│   ├── models/
│   │   ├── settings_model.dart
│   │   └── models.dart
│   └── repositories/
│       ├── settings_repository.dart
│       └── repositories.dart
└── ui/
    ├── view_models/
    │   ├── settings_view_model.dart
    │   └── settings_view_model_state.dart
    └── views/
        ├── settings_view.dart
        └── widgets/
            ├── currency_selector.dart
            ├── language_selector.dart
            └── theme_selector.dart
```

## Funcionalidades

### 1. Tema (Dark/Light Mode)
- Permite alternar entre modo claro e escuro
- Configuração salva localmente usando SharedPreferences
- Interface com switch toggle
- **Aplicação em tempo real**: O tema é aplicado imediatamente em toda a aplicação

### 2. Idioma
- Suporte para Português (pt) e Inglês (en)
- Seleção via dialog com radio buttons
- Configuração salva localmente
- **Aplicação em tempo real**: O idioma é aplicado imediatamente em toda a aplicação

### 3. Moeda
- Suporte para Real Brasileiro (BRL), Dólar Americano (USD) e Euro (EUR)
- Seleção via dialog com radio buttons
- Configuração salva localmente
- **Aplicação em tempo real**: A moeda é aplicada imediatamente em toda a aplicação

## Como usar

### Acessar configurações
1. No dashboard, toque no ícone de menu (três pontos verticais)
2. Selecione "Configurações"
3. Ou navegue diretamente para `/settings`

### Alterar configurações
- **Tema**: Toque no switch para alternar entre claro/escuro
- **Idioma**: Toque na opção para abrir dialog de seleção
- **Moeda**: Toque na opção para abrir dialog de seleção

## Arquitetura

### MVVM Pattern
- **Model**: `SettingsModel` - representa as configurações do usuário
- **View**: `SettingsView` - interface do usuário
- **ViewModel**: `SettingsViewModel` - lógica de negócio e estado

### State Management
- Usa Riverpod para gerenciamento de estado
- Estados: `Initial`, `Loading`, `Loaded`, `Error`
- **Locale Provider**: Gerencia mudanças de idioma globalmente
- **Theme Mode**: Aplica tema dinamicamente baseado nas configurações

### Data Layer
- **DataSource**: `SettingsDataSource` - acesso direto ao SharedPreferences
- **Repository**: `SettingsRepository` - abstração do acesso aos dados

## Configuração no main.dart

```dart
void main() async {
  // ... outras inicializações
  
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        settingsDataSourceProvider.overrideWithValue(
          SettingsDataSource(prefs),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```

## Localização

As strings estão definidas em:
- `lib/src/core/l10n/strings/app_en.arb` (Inglês)
- `lib/src/core/l10n/strings/app_pt.arb` (Português)

### Novas strings adicionadas:
- `settings` - Título da tela
- `appearance` - Seção de aparência
- `language` - Seção de idioma
- `currency` - Seção de moeda
- `darkMode` / `lightMode` - Opções de tema
- `portuguese` / `english` - Opções de idioma
- `brazilianReal` / `usDollar` / `euro` - Opções de moeda
- `retry` - Botão de tentar novamente

## Rotas

A rota `/transactions/settings` está configurada no `AppRoutes` e pode ser acessada via:
```dart
AppRoutes.goToSettings(context);
```

**Nota**: A rota está posicionada antes da rota dinâmica `:id` para evitar conflitos de roteamento.

## Persistência

As configurações são salvas localmente usando SharedPreferences em formato JSON:
```json
{
  "currency": "BRL",
  "isDarkMode": false,
  "language": "pt"
}
```
