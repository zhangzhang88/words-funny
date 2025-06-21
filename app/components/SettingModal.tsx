import {
  Modal,
  ModalContent,
  ModalHeader,
  ModalBody,
  Listbox,
  ListboxItem,
  Switch,
  ModalFooter,
} from "@heroui/react";
import { SignOutButton } from "./SignOutButton";
import { useAtom } from "jotai";
import { useAppTheme } from "~/hooks/useAppTheme";
import { WebsiteButton } from "./WebsiteButton";
import { isSettingModalOpenAtom } from "~/common/store";

export const SettingModal = () => {
  const [isSettingModalOpen, setIsSettingModalOpen] = useAtom(
    isSettingModalOpenAtom,
  );

  const { isDarkMode, toggleTheme } = useAppTheme();

  return (
    <Modal
      isOpen={isSettingModalOpen}
      onOpenChange={setIsSettingModalOpen}
      backdrop="blur"
    >
      <ModalContent>
        {(onClose) => {
          return (
            <>
              <ModalHeader>设置</ModalHeader>
              <ModalBody>
                <Listbox aria-label="settings">
                  <ListboxItem
                    onPress={() => {
                      toggleTheme();
                      onClose();
                    }}
                    key="darkmode"
                    endContent={
                      <Switch
                        isSelected={isDarkMode}
                        onValueChange={toggleTheme}
                      />
                    }
                  >
                    夜间模式
                  </ListboxItem>
                </Listbox>
                <SignOutButton />
                <WebsiteButton />
              </ModalBody>
              <ModalFooter />
            </>
          );
        }}
      </ModalContent>
    </Modal>
  );
};
