import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ações Rápidas',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Spacing.md),

        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                'Nova Receita',
                Icons.add_circle_outline,
                Colors.green,
                () {
                  // TODO: Navegar para adicionar receita
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Adicionar receita - Em breve!'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: _buildActionCard(
                context,
                'Nova Despesa',
                Icons.remove_circle_outline,
                Colors.red,
                () {
                  // TODO: Navegar para adicionar despesa
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Adicionar despesa - Em breve!'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: Spacing.md),

        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                'Gasto Recorrente',
                Icons.repeat,
                context.colorScheme.primary,
                () {
                  // TODO: Navegar para adicionar gasto recorrente
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gasto recorrente - Em breve!'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: _buildActionCard(
                context,
                'Relatórios',
                Icons.analytics_outlined,
                Colors.blue,
                () {
                  // TODO: Navegar para relatórios
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Relatórios - Em breve!')),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: Spacing.xs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
