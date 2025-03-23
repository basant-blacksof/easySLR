import { useSession } from "next-auth/react";
import { useRouter } from "next/router";
import { useEffect, type ComponentType } from "react";

const withAuth = <P extends object>(WrappedComponent: ComponentType<P>) => {
  const ComponentWithAuth = (props: P) => {
    const { status } = useSession();
    const router = useRouter();

    useEffect(() => {
      if (status === "unauthenticated") {
        void router.push("/signin");
      }
    }, [status, router]);

    if (status === "loading") {
      return <div>Loading...</div>;
    }

    if (status === "authenticated") {
      return <WrappedComponent {...props} />;
    }

    return null;
  };

  ComponentWithAuth.displayName = `withAuth(${
    WrappedComponent.displayName ?? WrappedComponent.name ?? "Component"
  })`;

  return ComponentWithAuth;
};

export default withAuth;
