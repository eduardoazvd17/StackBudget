import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/categories/data/models/models.dart';

abstract class CategoryDatasource {
  Future<List<CategoryModel>> getCategoriesByUser(String userId);
  Future<List<CategoryModel>> getCategoriesByUserAndType(
    String userId,
    TransactionTypeEnum? type,
  );
  Future<CategoryModel> createCategory(CategoryModel category);
  Future<CategoryModel> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String categoryId);
  Future<CategoryModel?> getCategoryById(String categoryId);
  String generateCategoryId();
  Future<void> createDefaultCategories(String userId);
}

class CategoryDatasourceImpl implements CategoryDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<CategoryModel>> getCategoriesByUser(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('categories')
          .where('userId', isEqualTo: userId)
          .orderBy('name')
          .get();

      return querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Failure(message: 'Erro ao buscar categorias: ${e.toString()}');
    }
  }

  @override
  Future<List<CategoryModel>> getCategoriesByUserAndType(
    String userId,
    TransactionTypeEnum? type,
  ) async {
    try {
      Query query = _firestore
          .collection('categories')
          .where('userId', isEqualTo: userId);

      // Se type for null, busca categorias que não têm tipo específico OU do tipo especificado
      if (type != null) {
        // Buscar categorias que são do tipo específico OU que não têm tipo (genéricas)
        // Como Firestore não suporta OR com where, vamos fazer duas consultas
        final specificTypeQuery = await query
            .where('type', isEqualTo: type.name)
            .orderBy('name')
            .get();

        final genericQuery = await query
            .where('type', isNull: true)
            .orderBy('name')
            .get();

        final allDocs = [...specificTypeQuery.docs, ...genericQuery.docs];
        
        // Remover duplicatas por ID
        final uniqueDocs = <String, QueryDocumentSnapshot>{};
        for (final doc in allDocs) {
          uniqueDocs[doc.id] = doc;
        }

        final categories = uniqueDocs.values
            .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        // Ordenar por nome
        categories.sort((a, b) => a.name.compareTo(b.name));
        return categories;
      } else {
        final querySnapshot = await query.orderBy('name').get();
        return querySnapshot.docs
            .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      throw Failure(message: 'Erro ao buscar categorias por tipo: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel> createCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection('categories')
          .doc(category.id)
          .set(category.toMap());

      return category;
    } catch (e) {
      throw Failure(message: 'Erro ao criar categoria: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      await _firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());

      return category;
    } catch (e) {
      throw Failure(message: 'Erro ao atualizar categoria: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
    } catch (e) {
      throw Failure(message: 'Erro ao excluir categoria: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel?> getCategoryById(String categoryId) async {
    try {
      final docSnapshot = await _firestore
          .collection('categories')
          .doc(categoryId)
          .get();

      if (!docSnapshot.exists) {
        return null;
      }

      return CategoryModel.fromMap(docSnapshot.data()!);
    } catch (e) {
      throw Failure(message: 'Erro ao buscar categoria: ${e.toString()}');
    }
  }

  @override
  String generateCategoryId() {
    return _firestore.collection('categories').doc().id;
  }

  @override
  Future<void> createDefaultCategories(String userId) async {
    try {
      final defaultCategories = _getDefaultCategories(userId);
      
      // Verificar se já existem categorias padrão para este usuário
      final existingCategories = await getCategoriesByUser(userId);
      final hasDefaultCategories = existingCategories.any((cat) => cat.isDefault);
      
      if (hasDefaultCategories) {
        return; // Já existem categorias padrão
      }

      // Criar categorias padrão em batch
      final batch = _firestore.batch();
      
      for (final category in defaultCategories) {
        final docRef = _firestore.collection('categories').doc(category.id);
        batch.set(docRef, category.toMap());
      }
      
      await batch.commit();
    } catch (e) {
      throw Failure(message: 'Erro ao criar categorias padrão: ${e.toString()}');
    }
  }

  List<CategoryModel> _getDefaultCategories(String userId) {
    final now = DateTime.now();
    
    return [
      // Categorias de Despesa
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Alimentação',
        description: 'Supermercado, restaurantes, delivery',
        icon: 'restaurant',
        color: '#FF5722',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Transporte',
        description: 'Combustível, transporte público, Uber',
        icon: 'directions_car',
        color: '#2196F3',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Moradia',
        description: 'Aluguel, financiamento, condomínio',
        icon: 'home',
        color: '#4CAF50',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Contas',
        description: 'Luz, água, internet, telefone',
        icon: 'receipt',
        color: '#FF9800',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Saúde',
        description: 'Médico, farmácia, plano de saúde',
        icon: 'local_hospital',
        color: '#E91E63',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Educação',
        description: 'Cursos, livros, material escolar',
        icon: 'school',
        color: '#9C27B0',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Lazer',
        description: 'Cinema, viagens, entretenimento',
        icon: 'movie',
        color: '#00BCD4',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Compras',
        description: 'Roupas, eletrônicos, presentes',
        icon: 'shopping_bag',
        color: '#795548',
        type: TransactionTypeEnum.expense,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),

      // Categorias de Receita
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Salário',
        description: 'Salário principal',
        icon: 'work',
        color: '#4CAF50',
        type: TransactionTypeEnum.income,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Freelance',
        description: 'Trabalhos extras, consultoria',
        icon: 'laptop',
        color: '#2196F3',
        type: TransactionTypeEnum.income,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Investimentos',
        description: 'Dividendos, juros, rendimentos',
        icon: 'trending_up',
        color: '#FF9800',
        type: TransactionTypeEnum.income,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Outros',
        description: 'Outras receitas',
        icon: 'attach_money',
        color: '#607D8B',
        type: TransactionTypeEnum.income,
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),

      // Categoria genérica
      CategoryModel(
        id: generateCategoryId(),
        userId: userId,
        name: 'Outros',
        description: 'Categoria genérica',
        icon: 'category',
        color: '#9E9E9E',
        type: null, // Pode ser usada para ambos
        isDefault: true,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}
