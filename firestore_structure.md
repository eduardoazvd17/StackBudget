# Estrutura Otimizada do Firestore - StackBudget

## Visão Geral

A estrutura foi projetada para otimizar consultas mensais e minimizar leituras desnecessárias, seguindo as melhores práticas do Firestore.

## Coleções Principais

### 1. `users`
Armazena informações básicas dos usuários.
```
/users/{userId}
```

**Campos:**
- `id`: String (ID do usuário)
- `email`: String
- `name`: String  
- `registrationDate`: Timestamp
- `lastLogin`: Timestamp

---

### 2. `transactions`
Armazena transações base (templates para recorrentes, parceladas, etc.)
```
/transactions/{transactionId}
```

**Campos:**
- `id`: String
- `userId`: String
- `title`: String
- `description`: String (opcional)
- `amount`: Number (valor base)
- `type`: String (income/expense)
- `frequency`: String (oneTime/monthly/yearly/installment)
- `createdAt`: Timestamp
- `updatedAt`: Timestamp
- `startDate`: Timestamp (opcional)
- `endDate`: Timestamp (opcional)
- `totalInstallments`: Number (opcional, para parceladas)
- `currentInstallment`: Number (opcional, para parceladas)
- `yearlyMonth`: String (opcional, para anuais)
- `isDynamic`: Boolean (se permite alteração mensal)
- `category`: String (opcional)
- `tags`: Array<String> (opcional)

**Índices Necessários:**
- `userId, frequency`
- `userId, type`
- `userId, startDate, endDate`

---

### 3. `monthlyTransactions`
Armazena transações específicas por mês (para valores dinâmicos)
```
/monthlyTransactions/{monthlyTransactionId}
```

**Campos:**
- `id`: String
- `userId`: String
- `parentTransactionId`: String (referência à transação pai)
- `year`: Number
- `month`: Number
- `amount`: Number (valor específico do mês)
- `notes`: String (opcional)
- `createdAt`: Timestamp
- `updatedAt`: Timestamp
- `isCustomAmount`: Boolean

**Índices Necessários:**
- `userId, year, month`
- `parentTransactionId`
- `userId, parentTransactionId`

---

### 4. `monthlyBudgets`
Resumos mensais otimizados para consultas rápidas na tela principal
```
/monthlyBudgets/{monthlyBudgetId}
```

**Campos:**
- `id`: String
- `userId`: String
- `year`: Number
- `month`: Number
- `plannedIncome`: Number
- `actualIncome`: Number
- `plannedExpenses`: Number
- `actualExpenses`: Number
- `createdAt`: Timestamp
- `updatedAt`: Timestamp
- `plannedExpensesByCategory`: Map<String, Number> (opcional)
- `actualExpensesByCategory`: Map<String, Number> (opcional)

**Índices Necessários:**
- `userId, year, month` (índice composto único)
- `userId, year` (para consultas anuais)

---

## Estratégia de Consultas Otimizadas

### 1. Tela Principal (Dashboard)
**Consulta única para o mês atual:**
```dart
// Busca apenas o resumo mensal
FirebaseFirestore.instance
  .collection('monthlyBudgets')
  .where('userId', isEqualTo: userId)
  .where('year', isEqualTo: currentYear)
  .where('month', isEqualTo: currentMonth)
  .limit(1)
```
**Custo: 1 leitura**

### 2. Listagem de Transações do Mês
**Busca transações aplicáveis ao mês:**
```dart
// 1. Buscar transações recorrentes ativas
// 2. Buscar transações específicas do mês
// 3. Buscar parceladas que incidem no mês
```
**Custo: ~3-5 leituras dependendo dos filtros**

### 3. Filtro por Ano
**Busca resumos de todos os meses do ano:**
```dart
FirebaseFirestore.instance
  .collection('monthlyBudgets')
  .where('userId', isEqualTo: userId)
  .where('year', isEqualTo: selectedYear)
  .orderBy('month')
```
**Custo: 12 leituras (máximo)**

---

## Regras de Negócio Implementadas

### 1. Transações Recorrentes Mensais
- **Template** armazenado em `transactions`
- **Valores específicos** (se alterados) em `monthlyTransactions`
- **Resumo** calculado e armazenado em `monthlyBudgets`

### 2. Transações Parceladas
- **Template** com `totalInstallments` em `transactions`
- **Cálculo automático** das parcelas por mês
- **Atualização** do `currentInstallment` conforme pago

### 3. Transações Anuais
- **Template** com `yearlyMonth` em `transactions`
- **Aplicação** apenas no mês especificado de cada ano

### 4. Transações Únicas/Variáveis
- **Registro direto** em `transactions` com `frequency: oneTime`
- **Data específica** para aplicação

---

## Benefícios da Estrutura

1. **Performance**: Consultas mensais custam apenas 1-5 leituras
2. **Escalabilidade**: Estrutura cresce linearmente com o uso
3. **Flexibilidade**: Suporta todos os tipos de transação requeridos
4. **Manutenção**: Resumos pré-calculados aceleram a UI
5. **Economia**: Minimiza leituras desnecessárias do Firestore

---

## Considerações de Implementação

### Cloud Functions (Futuras)
Para manter os resumos mensais sempre atualizados:
- Trigger ao criar/atualizar transações
- Recálculo automático dos `monthlyBudgets`
- Processamento de transações recorrentes

### Caching Local
- Usar Riverpod para cache em memória
- Persistir resumos mensais localmente
- Sincronização inteligente com Firestore

### Backup e Migração
- Estrutura permite export/import fácil
- Dados organizados por usuário e período
- Possibilidade de arquivamento por ano
