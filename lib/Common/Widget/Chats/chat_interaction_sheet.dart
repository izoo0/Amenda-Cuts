import 'package:amenda_cuts/Common/Widget/Chats/chat_interaction_action.dart';
import 'package:flutter/material.dart';

chatInteractionSheet({
  required BuildContext context,
  required String message,
}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).cardColor,
            child: SizedBox(
              width: 470,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black12),
                      child: Text(
                        message,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: reactionList.length,
                      itemBuilder: (context, index) {
                        final data = reactionList[index];
                        return ListTile(
                          leading: data.leading,
                          title: Text(
                            data.title,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
